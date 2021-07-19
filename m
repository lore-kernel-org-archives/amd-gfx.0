Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B827C12002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 05:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C46260FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 05:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C46260FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8D89F6B;
	Mon, 19 Jul 2021 05:58:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C254189F6B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 05:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ6LioYJiAtRKWF7u2l2Gp36rriw7Mht0gi7xlXLfFrr22Zqq/DWx0ZzrfZh4M+rvNXjqXnNySO9iNUWhbDreZyhMoSnhti3KW6so8BxgjyPC/MutCNVyIyf2lNJsLJLYx3prGoXyPginSkqIoic1SuDp98o8SVrEzYxtRpEFRVyeMresu8vou5pl6uGU18YkxPhbRaxdG7LTxwI9AxCASqXvj+oTMaG57MUKnhqKiA2q0JeQxg9KkXIshGe3t9KEwPJexnQcCMb2Tgz8iE+lgaJryDPDtZCGvby0QA1HCdT4VRSQxp7IxxtXbkdvcAeWy63AvAZoUS076FQRzJhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHhgnU2iwX9ATz3Pl8X3NHfP/QvBxonFdFMJdwbTGNc=;
 b=CHE+W8XVZQVgvyZi3fQwqd8c3xPs1hkXA1XiyfonElc9HbG2Rg/PvDecNUlCa3vDtsHyhbvARXGuxEASvEE9Yej9HC8IpbUKSs/smt3srXGrcQDkaeuYkKcFalgIvKiVPXOyUhJDalAJvqk2u6H4GE8hz5Y0pftUeNuWUi/YxQQ964yyZbteLfWCMas+iaXNwAPaw+zhx77lS57RnPmOJ7IdWoUp1D2EN6rjQ+bH6/ktolqy0FUO2CDmOTHvVzTdhxaLKtByLYWhio0FX7iaBtIkibZkZYLL6kv2U5w4vB7RpZfcxpy+DcsS/ebE6+OHc36kYm+kNpgRn+kpJ38f9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHhgnU2iwX9ATz3Pl8X3NHfP/QvBxonFdFMJdwbTGNc=;
 b=A/rHqbgjKZtT5F6WhKY2qwtiY5T9av0IVXCwsWgVsnBJNNxQErjq7m9jAmDePyrY7f8kGxUuSSbwl4kfaR2peYfIw5CO0Yb0kU3R6PJ4qfseWpbw6FWtwKLDmHeL/CO/4Uq1B4b4wXdxqLcX8aBH9XS7h1x3Ci38YwITbWrGFqI=
Received: from DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23)
 by MN2PR12MB4638.namprd12.prod.outlook.com (2603:10b6:208:ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 05:58:25 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::66) by DM6PR13CA0046.outlook.office365.com
 (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend
 Transport; Mon, 19 Jul 2021 05:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 05:58:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 00:58:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 00:58:24 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 00:58:22 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Date: Mon, 19 Jul 2021 13:57:55 +0800
Message-ID: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50a47ae3-b94e-4d83-bf7e-08d94a7a38ff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4638:
X-Microsoft-Antispam-PRVS: <MN2PR12MB463816A246A130AB22FB4EE5B7E19@MN2PR12MB4638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kY+mRZb67g1bDYB3oInT3zqjT5i1caefYwY3Aczay6VPltrQxvzFyNRlG9mmtEZauLp7sEu7PDmKY57s7nWZHIsO9hXtQZjg/n5/x/IIOW7AhW5jpRLtug18r95iPGSBHGpUcdz9PAbI8urkHsRT+pWvWtXoYy4qPtlNWCTP0LnJbrl77WlFVk/l9KQOP5H4xfADDmvnVtrVyxZ0k05zAXvGRgWEJiKZth47Yl7tQAFood49D0WszZLK0wZcsHyA2N6LeIImkMu392Bd1uJXm7ZlivHnvIDzfUY6JM//AhqY7u2ghhnnpErjn9rUI8pdL4bjilUXqegwjOTa4+hoRLSeobeuxiGEhqlUDwcqCVwGzON1i+H1iiwS/1Tdat4KD7xNRGQgRNdjRUZ0oFiGM8jPiinWNkiwLqLMhYoceVocUqR2M+nbPU99lvYGCm15tvb6EyRiBMxn3fDHBx0IojF42VNg7WsewVkrsfaHGAOxJ4ip6hD03K52b1Bx+TdiohDgxjlTF5A6yycVoYivNdX6q6S9AFMcv4dJ+rB8wMz5WZIGPXoH5A382KFANP0RmP4wnhNZbYIMiASCzLc3qnVQXFHxOVcx5ze2tXEBUPt+7Cvv2fu9krnHefoHIxGNJbqHIDnyIIWF5SWeX5OeZrhq9sI+Wr3FdvO2gnqFm2qqFDqkYnC3Ek6OaxtlPLM8eZzoz4Nj9vA+p5A4Wk1OyPuV+OdNZU+gZPeNJf6aw9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(36860700001)(336012)(2616005)(426003)(356005)(8676002)(1076003)(36756003)(5660300002)(7696005)(83380400001)(6666004)(186003)(4326008)(478600001)(70206006)(70586007)(86362001)(47076005)(82740400003)(81166007)(26005)(2906002)(54906003)(82310400003)(8936002)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 05:58:25.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a47ae3-b94e-4d83-bf7e-08d94a7a38ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4638
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Current vm_pte entities have NORMAL priority, in SRIOV multi-vf
use case, the vf flr happens first and then job time out is found.
There can be several jobs timeout during a very small time slice.
And if the innocent sdma job time out is found before the real bad
job, then the innocent sdma job will be set to guilty as it only
has NORMAL priority. This will lead to a page fault after
resubmitting job.

[How]
sdma should always have KERNEL priority. The kernel job will always
be resubmitted.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 358316d6a38c..f7526b67cc5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2923,13 +2923,13 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	INIT_LIST_HEAD(&vm->done);
 
 	/* create scheduler entities for page table updates */
-	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
+	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_KERNEL,
 				  adev->vm_manager.vm_pte_scheds,
 				  adev->vm_manager.vm_pte_num_scheds, NULL);
 	if (r)
 		return r;
 
-	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
+	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_KERNEL,
 				  adev->vm_manager.vm_pte_scheds,
 				  adev->vm_manager.vm_pte_num_scheds, NULL);
 	if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
