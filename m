Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3CC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECB761934
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECB761934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BD16E255;
	Mon, 29 Mar 2021 07:49:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5766E209
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 07:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgqcXeEk2ndMALTtycQtBFHFvxDTLaUxXTHaFBxZw5WI2Bqysq7mpb1c2yrEHUvh1WXZm9uc/HP9qkRHxv3r0504hs+gvEn3Q9NbgvxxwJsINSPgioEjuIDyTNRu56/hudF3vhc8S6xbtd1zu9ozvYkmniCheKXUWAC3sEhuwyv70AU9eAa1jUczBSxTzsZ18xeCn/nOU/gqgiXYl2Alek8u3tvwy7siHdl3zw1rCWVg/4UDqTIj29VCrDZ8WnVhztoQygnbkjqZPVbuxGS1VIRdH1lchE7cOCVIzDz24fJF1GpvS4xwCnfSD1yJHgtNqtgOegFirYIXx39VDZpAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOKw2AJQ1mx/rjvbhF7+cSBUKFXVM01cJlOlkhzheg=;
 b=AuVUisLeQGQS7e0Uzs10D0hzorWEK9zpPrmtgVIaQU8chwzrikSErtsHq+GE58qgyp88ox7eD9/fqzT8cxYRKhMP9WUIaCkgtjCrl220fc1oq10xZW7mBjnJDo7aV/qr0xaMG5nN+0VMw+8gl+DcBobfD/551IHNGGrAwLAfknvP0bQ5w4IXhsqbTTN2c4npLPR/2ADFt/clDzftrQwjSueeA47sZtSXJN5Q539rgmr/sfTHWQ4imDd2+Qy2J7PVo9Vgw4l1MkXTT3qSr0koRHUERRvbp5Pc+W1Kn0L7C6qlustIyBSahyNM1cQlPomzmLNK2hYd5gJIIUND9FNe8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOKw2AJQ1mx/rjvbhF7+cSBUKFXVM01cJlOlkhzheg=;
 b=3+ogXcsui4zyz+IkL85OVC4Cws95PlEJ6bdGaa1SyT6MPqI//w7XttyPvT0ihPf9jQ7bVzlN1ho0RBq+Z73nAh14GBetD52FMHQH3r5lqOt5JSYZOgRsETSkJVrSSSvviI5lhO1T74Xa+mh/SqZazBRYxNDhRH4v0lswUvzlON0=
Received: from BN7PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:20::48)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 07:49:48 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::9c) by BN7PR02CA0035.outlook.office365.com
 (2603:10b6:408:20::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Mon, 29 Mar 2021 07:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 07:49:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:47 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 02:49:46 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
Date: Mon, 29 Mar 2021 15:49:31 +0800
Message-ID: <20210329074935.10822-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329074935.10822-1-Emily.Deng@amd.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4c07c2-b888-43b1-6bb6-08d8f2873a4b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5100:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5100AE3E360C4D910F9F7E838F7E9@BN9PR12MB5100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idUqlck1uVKL1gAPLo79POOeO1M5oLbRM9X+IJKOuJX3/vnzDaMWDqNlC21/F53JtUrKM/OhslCwlCuBznNghuxntHsZZ9R+FOY88RRpQ8IbDzGUr52tanoB8aRRy3BQH78M7oi+K6f3Apgtw7+F2k6+OqUIMCAVlDtsIyuc3WJqtQF02bIPtuBxn6vHoF9SNIxabsvkydlm5/UolxkIJH1brMZSbdxcJqdwpul3IkKBgtp7GYdu+NykyQ2J5tGD9PGRae9CGd807oyykM1JTN2qzQUsl3f1Lw5IXnvjYn94utAHTog1reejORIPZduMbMXDAVSIQigey+ZXYDxacUAPlv/UXFd0ucl5Lwr8qy/eqE8CXVbyC7vkTVB1C0TAPnMK6QozCamqWjmqo6habEwBL4mTJFqbXQq8nFqK+FiZDwrFA5wHQ5YNABUqFCXokzbjwwFXaNyj3rueYNEGmVN8U0TKxEbBlWFuaID9PTbSZAUQlUmYhJemOtFe9MQkwWKaCZvtDHH5kAU/qpxTiNyrec2xpCWq9bTeeCJpsomLMKiUNN10QPyLtx83nICfjUmFoJqG9EzfR5mTBIxIdqAI8Swt8j9TqKDnRfV/P/1WqSDdvMSc0PgkLNJITpfbAxG2maMUM5TwjVhmy/0/jAZAV5u6+7wMa6+Ru6xXeG5ExZR0uKqA1RrugIhyP31Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(82310400003)(82740400003)(6666004)(8936002)(36756003)(6916009)(83380400001)(2616005)(8676002)(5660300002)(70206006)(70586007)(316002)(36860700001)(336012)(426003)(47076005)(2906002)(186003)(478600001)(4744005)(81166007)(7696005)(356005)(86362001)(1076003)(4326008)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:49:48.5013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4c07c2-b888-43b1-6bb6-08d8f2873a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the num_types equal to the enabled num_crtc.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 5c11144da051..c03a83a2b7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -768,7 +768,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
 
 static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
+	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
