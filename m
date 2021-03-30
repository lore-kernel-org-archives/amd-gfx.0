Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2756C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6192161606
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6192161606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3C26E2DF;
	Tue, 30 Mar 2021 04:41:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37036E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfRvzNWrJ/fXmK659DXE3+A8qnRXKjJNK+iby4u5kVx2NlSGzTgoWlhGAqA35i7Bavbl5BocZN/2bmpyQxKbnr8qijd5G1iWFcvPMKSZIDpHHtlbj9q1NL7uIvFNsTg64Ho8jL0JzOCZtajrz+rUjFDNyFtpuVJTfBBwioYjZRb2Ag5Gsf26KaIHpglZVA4jJOHZaNLU4NOb7MW3HzTvEd15Jm+GhZ3S3hGfaj7TedGhufyU2hMaSUHqAyEG+7T1IhJ+I7ck92z9j84i/Pqf792rO3Joqvujwsq8x5uZ92NpswkOdCmqVYMx5m7SvuUqZiJC4RpZ8xnvZkNwxcaYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOKw2AJQ1mx/rjvbhF7+cSBUKFXVM01cJlOlkhzheg=;
 b=FE74fiSM8IbQy4X8dkwyc1IMHU1tEv986CeCf7jJPPwXk+3X89YGHZX3F+6SSZBMvVLMTgTmP1Mp5Wj5bGMKaGQpzTR7B26FkebQCOOGOtdY0NyXh2MOg6Rhmlt+7/swl6tQXTBlrcQWOe5XjOf/YqF9xYXd/RD7/UXYTFWLT5GusTC/7MVXfI1G26DOzWK4F1MwpnFdP0LZsJZHbe4b/g/CSEFZ5rjm+G5vGkAt5pNR4nCOMQ89M+145bj0chbRQe4WcY9PMFvRhY9cuRu8WMfLgKpSxeUuyJ4ilW3BeXfacGNnHdSTWcRlTnX2zNf16td9TYvStI43ToQjThjhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOKw2AJQ1mx/rjvbhF7+cSBUKFXVM01cJlOlkhzheg=;
 b=yOAxTACGlt7n3L2I9mwGADBKJf3F3xneGkaXmImvlyCaDg0ELzZG7zarRDoEfxnr+XwOQLHf8HkF9ijfzjbZnzemHYiQJR1J0KdNPwhxpa9fEOz52PcQUs/EggtzaJY10jX7i3kAKdqS7R3nALGb/DYctlWWJAayPD0b1TKUbGA=
Received: from MWHPR18CA0061.namprd18.prod.outlook.com (2603:10b6:300:39::23)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 04:41:54 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::2f) by MWHPR18CA0061.outlook.office365.com
 (2603:10b6:300:39::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 04:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:41:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:41:51 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:41:51 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
Date: Tue, 30 Mar 2021 12:41:43 +0800
Message-ID: <20210330044147.57802-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330044147.57802-1-Emily.Deng@amd.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b256f8ac-2b60-4a16-4bc4-08d8f336242f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42695D458816DAA46AA456408F7D9@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJaGq5FBXZKA02efhGJk1dNUi5QRaKzsWXut76WMwBGyLcMa0z3Slb9hsUo4M0r4INNC2lf/kHJzX/S7NTeLIbF5StfI64AuZ9JgSBOqgd+gS1PR+N4/h38CwdQTRLwiAQhsyTcQ16Vo71w1DMi+ikXzvqBXQuW3PD1PDFtB6K3nOVR3oI96p1Bn4UDCnHHwS6ZQ64FOQTOjBTpNAg0jMT3j7PcwfFLGqKn2cSHPmgYnxRbZbhL+TcC583oRqUvZ7CPm4oveG40/KgT5WhwTpGrdepwu5042j3MidryfdWiQLvNt2xdiOM2nP/FnmuXAtQ+8PMPI8COU3KhNVP3r5h+NFZgz6d5zcNSj+SbHb9hfDxw0GgFiqsmz+9dqEXMeGVIwPaPHRDKRETl4MEnoaPtR8hHNiO40m5LgqiPCV6xPQ5OeE3qgHtsEC5O0VSotDRM9HQnMgJ3WdphCj9VfwedjrxxCJq4LjK1GAX0P+c9k2cqQ8PVPfrgkiT7VDb28R1INo6iNMPlGdCmb+T3yCY6Um7Xg1j6ziKx9cWTGn5W+BjVrym+b5LJLHIvVoR4+hhoLDg/z0h1tSUt6OoUo2/gUHTk/S5s3yNgh6NNrhCxDCofgw0wdBq2OKFtg8cXcnKKHFFBg5J5VH+8vygON6xUPKol1YHvm7I6YrQTiU278wf2Qwi1bFBIMPJSXNbRn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(2906002)(70586007)(5660300002)(4326008)(70206006)(81166007)(36860700001)(26005)(82310400003)(82740400003)(7696005)(478600001)(8936002)(6916009)(1076003)(336012)(47076005)(316002)(8676002)(2616005)(4744005)(6666004)(426003)(186003)(36756003)(86362001)(83380400001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:41:53.2208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b256f8ac-2b60-4a16-4bc4-08d8f336242f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
