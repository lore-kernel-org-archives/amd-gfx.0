Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F3C388F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D602A21D6C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KLH1SVZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D602A21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201636E10F;
	Thu, 22 Oct 2020 03:43:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A3A6E10F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMpie7bZfcAiW5egkfQ8kjkc87LTDrN5uGoC5/4TxIGh6Ihk/Hyrukup4ZK7zpPU7fgh777GVk2saLteGKaqYBqFqs8YHzxlgi/0ST8SIrm0mmuGFbqZTMxMHWeDUl+f9k7ZbG0TTCNVJ7n7pqBO0Elzl0YidHkVftJ853UrJyKEJdZnbkrRY4YNm+zyCjJ0QkLNwG3CBXiLBaeoLMC12cMpgZSjguix3kfCXElgqIRaDax2hbaK7fd/U36ska2KDF8ifJ+Y+nK1MY/jQn6+BobCf+rjerQd7EYR9fjkCFxAbhA5htoY1XUYYt4qEbCRIbgSvF0lpr7Mi6mMkZlAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V47mnsc6l5GmcNoRqQ6EW+NQNc9fdqdW3sNEg3ewai0=;
 b=f7Tfr3jfi5xAQpcfca1GDUtpuLSQUxxou4VGMO+wxaUh6uDoR6+Sb0mSnxTEeY5U7jd6FaC+TE1qHm3d3jao4ElIxmHbBVjagvm4hosmF/KsW/Q41fjJ+5eRmyMeMYRxo3Z5cHmogZV2qBcclUb3rJJQFBCurmPKpKqtEAOWvomUUVMEsgVa+IOVt0vP/tgQuQJsRrvqwHXCVHMRHqtegk+BYmWzZKXe/XvvQ0v4NxrAZfr5sot7ZKPHySXJFFL9kXsKBYxJqW1ut9OblRqsLMBqeS8UVIc76OqepSgvBbbmp+nZ/B+96O+i6yJh+S8K8c/LqfrVxuBQ+EauLvVUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V47mnsc6l5GmcNoRqQ6EW+NQNc9fdqdW3sNEg3ewai0=;
 b=KLH1SVZmhh6btnpGteKzcOeDHfoMuZg5IkHVsop0WdPJ1mJFALjrPGAOfWRK3s5IjYcTJ2qdk3mIEG3nsLqNWcUtqnNX3sh1dJwC7P3pS4zd0icnMTgUV7p8VJl7zVAm0SMl11DkSn/G0DxGtpv3LgAa0k55dELBZY16vH93NBI=
Received: from DM5PR2001CA0011.namprd20.prod.outlook.com (2603:10b6:4:16::21)
 by BYAPR12MB2648.namprd12.prod.outlook.com (2603:10b6:a03:69::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 03:43:15 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::74) by DM5PR2001CA0011.outlook.office365.com
 (2603:10b6:4:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 03:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 03:43:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 22:43:14 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 22:43:11 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add DID for navi10 blockchain SKU
Date: Thu, 22 Oct 2020 11:43:08 +0800
Message-ID: <20201022034309.7568-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26545594-f428-406a-45a8-08d8763c9b6b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2648:
X-Microsoft-Antispam-PRVS: <BYAPR12MB264800544B926209402F66F0951D0@BYAPR12MB2648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Umoqh25DEVqq90aWJkLaleHEgAfzTQ5opFx3401SuGE6JcLNb0ae3k7SFoh0AmLUDEDrPAHX0EuyyAGi5NmurAT5ypKX98hjhw0DqyTgXOSpufey7dDlqhCAEhYZrhKg2SCJkrtfw+glhKojKpsNOF02InuVj6IL9e1fyPfhwR5HxVgtzxKZT0c94J+yojOdTTEnOJMWizorwAP+wQfj6J5IQjq8nrGuoUOuWDDYiHC90rlvsVR1drYygDAVKr1oAx6jxI+sLlm1DEozz6NwWlsAV0hZLnXjOAu8xUMvyCfxHhNSaZ/ntAwPXK9l4E/tbu3O2HwqnMfOYbVrWn5HtSQJhLKnWOtsJLw6OfSjYWTb7IjJfbkcvCtTt7roa1yIiOotCSFZ8Yn2UzPpNV0taw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966005)(7696005)(1076003)(26005)(186003)(4326008)(2616005)(336012)(54906003)(5660300002)(8936002)(316002)(44832011)(6666004)(8676002)(6916009)(2906002)(81166007)(86362001)(36756003)(4744005)(426003)(47076004)(82740400003)(478600001)(70586007)(70206006)(356005)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 03:43:14.9559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26545594-f428-406a-45a8-08d8763c9b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2648
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

Change-Id: I58129e3aa88369c85929e4dde002cf43c3ff288a
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 564336c2ee66..13723914fa9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1066,6 +1066,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7319, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
+	{0x1002, 0x731E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	/* Navi14 */
 	{0x1002, 0x7340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
