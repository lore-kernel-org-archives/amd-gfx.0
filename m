Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D715C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 02:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E1A216FD
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 02:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E1A216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D54789DFD;
	Mon, 18 Jan 2021 02:47:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1A289DFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 02:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YerSJ1MSmmrWpeJBlcKlgJTmOKhCg9OZNak9b4wesKDa5sCxUiM32RMsiQT85NdS3mnQz3UBlkY8/JPPYmOqt5c5C8de8zNWqY4KfWRTyMhAHJ33mN92FzwJ3bEjvpp9Lvg19HIUwklBG20VAPSrbbXQjydWACtSxFVYFdcI3Ab2uVTR+UYDyO5Ta7z6lGElScP6F6XCWOL5vgaHIjNcz2g3NF1/cyYx18nnH7gEEgXU4L3yKxWT1svxl3iDddyZcuYB9SpkAaAQ0h+SG4TDjY0Bs4XQgqma6C7izMG4Fwc8S+szouLJlfwen6IXpHqNkS2xg20XwKNCuy4TF3e/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMr7zLPM1MDsz6kG7LkSPNwcb0VGN2+674LYCchcH94=;
 b=GUnlW0dKUq60DuiI0arSC6A2hzwyLBaZyFPbtTH9CtzEFZbJvWNqToo/Rs1qY2cct9JQ7qf+0Orcvg3qrHih+oTtUUAU8Fk8PmlPHj9vnhg5aS1QYv9q1e+IsKqaSYgAT7isTAozTErPMJrfpTdih2r4oBmpxN0Yl6KUnMzOdRI0vUwh/jHLv0XKT5OyOnORMkesocYTOWRWk7tRScSAzCugPh/Q6IqGeEpiKxdcgod6vdA+Cyn3MVFhOvA0S+7jOc42tXym/phhJeGsfm12GFZwI+ADpKBYKkJFhWrGUr3pkZ41HgFMxKYGUXFw8ndCfaQg6LqwAQujgHE/K+qSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMr7zLPM1MDsz6kG7LkSPNwcb0VGN2+674LYCchcH94=;
 b=HS4sbZW6oCHZCj7LBuU2W3ttvU7vSZvzI4BRiRs1ATEqmZGJBLmzds42bDsKjoUuHsJh7WAwvW9Y8bDw2AvzGU7NDz8QZGok8/iBDiUXR9i0r8mq4c0ur0Ne66glYpxZ//TI+9MG2I+d8NbE05xSqox23VVYJX+bKKL4x+Yl6Dg=
Received: from DM5PR20CA0041.namprd20.prod.outlook.com (2603:10b6:3:13d::27)
 by DM6PR12MB4634.namprd12.prod.outlook.com (2603:10b6:5:165::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Mon, 18 Jan
 2021 02:47:48 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::69) by DM5PR20CA0041.outlook.office365.com
 (2603:10b6:3:13d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Mon, 18 Jan 2021 02:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 02:47:46 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 17 Jan
 2021 20:47:43 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 17 Jan 2021 20:47:37 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: remove redundant flush_delayed_work
Date: Mon, 18 Jan 2021 10:47:15 +0800
Message-ID: <20210118024714.2730735-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93dd8417-ed6e-4fad-dab2-08d8bb5b6ff0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4634:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4634F8896AB51580BB6ECED2B7A40@DM6PR12MB4634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Phg0dEyfXZZAiLouSRVz4DxfIisw3VzQjoLqdYmojdWeuJKCRSQ80tAQ0wc+JDT6PcRrRD79+bZmLvNke+WIjYoabQnJ+VQ0eKihxXpCjS1Y8wqlQcpdCQ65Gzz9CsJ2Ha2DGjxzCb6R4j5YxWPcVDdUZDD5uhdo37KnCWrJBuxNUk5Hjep7Mtn8BAxUqVbb6t93P1lnK8rGuSH5yp/8+vQkjZMWNeG9IbDzfk3nrvOxEA3McHMRvk1gVIDZDlgJaF68UucKXW5lOHYZb/FN7DVgZuzrqWJDcT2xdCbvaunhSGeVHaPMczuVHx+tLm7xIF50ToxoUNhv6HFpyJp7zRe6+HAs0TnwptY6EqpSwMwHFjPuaB5nIrINXARN7Q74Wdi9hrzI0f1jGnMII5fO4TImnNPwxhhY5bRJsIclmA8xQOJuLOJnMvgtGaZwUAigrVmznqfOdvXJfFXh2gt19w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(1076003)(5660300002)(6666004)(2906002)(70206006)(70586007)(81166007)(6916009)(478600001)(83380400001)(4744005)(4326008)(86362001)(82310400003)(82740400003)(356005)(8676002)(7696005)(316002)(54906003)(36756003)(8936002)(186003)(26005)(426003)(336012)(2616005)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 02:47:46.6489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dd8417-ed6e-4fad-dab2-08d8bb5b6ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4634
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

When using cancel_delayed_work_sync, there's no need
to flush_delayed_work first. This sequence can lead to
a redundant loop of work executing.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3e212862cf5d..c649944e49da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -569,7 +569,6 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 {
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
 		DRM_INFO("clean up the vf2pf work item\n");
-		flush_delayed_work(&adev->virt.vf2pf_work);
 		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
 		adev->virt.vf2pf_update_interval_ms = 0;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
