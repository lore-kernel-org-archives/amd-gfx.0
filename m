Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA5C63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 05:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE54560232
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 05:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE54560232
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F3E06E956;
	Thu, 22 Jul 2021 05:49:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0ABD6E956
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 05:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsjOKNUrbkJSgyRNymvRDxXm5nnjZIdZiBNbaTxlDdBKERnncncSQY26XN2Bc+jpRoEnwZbltLz0fRTgfQ/U9FCh8mWSbpLmHvgVe5bKxN/225edXNIANTdtyxYQg5DjcEmCD9DwScomjRvxDUKmzS4jXerASvWUlnjBj8oTnhvk/JbteFZjCmShA9JZh755P5jS04hLVWsh1FvYxw4vmGHZSo09k2/K6XkHf0kouv4YYV4ruPmVY0dvWvab1O4LVZ4JiiZK5zp+1nWwWkOAWfbYwoFO0mwLmOzAgZuIMUfJOJpTePTjt8EJPaRRlLPfuDkbc7wQMv+t5NQuetCjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozeM4NwshbyM9vlES91uG0xZGkVfzios0AVGrLOsR08=;
 b=Wnk50Dv52t3VoL4xN8vC19SopoSSd/O3bBX0h2qh0OrorXZImBLG1ke7Vgwlj1iy+deKLy12g+TG4qP85+txUToKDWVEtSyFJhIrJfEx32UmI82M61HYlp861+7o+2v6waIX/RDLvQMUGeUlQ0bHCDB0aJOS1b0AygTb0CGmT3ZO/QzQ7z33E9jXyUr/ql4sr6nnfl0PWUZkd9qs6MjO9miAS0fpJ3DLIaMhZW7qldx5UhmuZl94g28WxqwfKVJl72OUraa2hr8ivdCvqUWrN/qAOoO5l4WCF6SM3sAOxvm8JydHwyhG63gcQo8WVLvKJgJewlIAB/kjnCOFcHdNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozeM4NwshbyM9vlES91uG0xZGkVfzios0AVGrLOsR08=;
 b=d/s4vppv0ZaxNKMF02/Ov895TfLilLIgZ6bRYgNH2jHPnO+pk5rd0rPRQORZ1ATLH+M0EEsoWiwalIvqNHl8krm5PA1Uk+MXYh5oBbfzTOiqMsdRz7U9civQk22XG8cIE+xbj2gaiW/DCsFz7wCEcCaARI2P+b8CjhrW2udB6N8=
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by BYAPR12MB4710.namprd12.prod.outlook.com (2603:10b6:a03:9f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 22 Jul
 2021 05:49:12 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::7c) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Thu, 22 Jul 2021 05:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 05:49:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 00:49:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 00:49:11 -0500
Received: from chengzhe-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 00:49:08 -0500
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add msix restore for pass-through mode
Date: Thu, 22 Jul 2021 13:49:05 +0800
Message-ID: <20210722054905.1790482-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c42c65-473a-40e3-07ad-08d94cd46ebb
X-MS-TrafficTypeDiagnostic: BYAPR12MB4710:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47100D608402898AFE6412C193E49@BYAPR12MB4710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZObikVIIM8J7N7q4sJFHJYWzjE/n4Kp7SYMrrggUF8haWiVzIW0enRzBEE9YrFq0bDqKtVKzZHSj38lQ6bz7CtLzDc7Vp3L5O5J91ZtUSGz0c1ciFhf+So6tanYcWWhiwB3eqXvbxrp58vTbxRiOASpXIvCdzf09GQKeDiEPmVliSJAi2+9Wr23eo9Ckf64ng7Z1Zp4sP9ApO59KPtQcLmpTqdynqlhuimgZ1zXt9ezUHegakq/Z1kP5jZBCZTY6je0BaMxaTZSkutGHY2LZ1YMRpSkYl28vLqxEnB0ndRB5nhO/uZFqsYFYgbHZJwrPlVQLGD/0UCfRwnxbKmbQUS4K3fSw9PYCfAKKG4d7GturQZmsjUbbcdfDo3mNjcKo8xZ5hhdpBiG6QcNQHEv33fnMQJazwx/cIiV/uleoTVIpw3upFxxABUDop6JlJMgxJHL5x6+/zYn2nHQoUqyL5c/PRNGpnCMSn7/5tSuhIlSEVGj3nkd329itpWrg3RVwATCEg9iUAXixgQ8WU+kuFeY7GzO3PRj3BLdeCuaz9m2XuOnoQQp+gIUuOelduLbxl16tnrTzfv+6/An/b/yEK0yYQ4tSwnIxqXcZbcVpZNk0yEWOSEw/hBOZ0c9YS57Tvar9vvu3PM/0s/Q9KEx+mLRY6hTZNEF20ge9u5tE+iuoGf6ZgHkIwvZhICBZk9ljl5DwFrUHokquhnV3jktTEoNv3rPjyOKdIUJdQO1yXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(478600001)(186003)(8936002)(426003)(70586007)(82740400003)(47076005)(26005)(8676002)(6666004)(2906002)(5660300002)(82310400003)(336012)(86362001)(1076003)(70206006)(83380400001)(36860700001)(6916009)(4326008)(81166007)(36756003)(54906003)(7696005)(2616005)(316002)(356005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 05:49:12.2385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c42c65-473a-40e3-07ad-08d94cd46ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4710
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
 Chengzhe Liu <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In pass-through mode, after mode 1 reset, msix enablement status would
lost and never receives interrupt again. So, we should restore msix
status after mode 1 reset.

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 83af307e97cd..e1aa4a5e6a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -584,7 +584,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
 		amdgpu_restore_msix(adev);
 
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
