Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C285BC11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 04:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8348B61460
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 04:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8348B61460
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389B489F8E;
	Thu,  1 Jul 2021 04:28:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4A489F8E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 04:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0k0RWlH773/Lr+sWSKyeBmXcrZVsLA02U6Q45W8N0tB1jSf+mCp8cAQVXP9iICoCamkGQpHKfDXmr3UIPJZxza5rDlATEVni67EwiZ3R9BUt/2VIq7U5AmOHSE4moDlRLVyx8n4IzXfiD9RXQMsFXqQAlCRzO5ItgNiGh25xZZO660jcQ2eJkvQdREwElpELlKytWJhaURZyx2E57S1S5/XNEbNTsmSwzuo7ZjJKJsiJC1KSUYqqISBurXOXPs8lfIP2lCmG0YWA/c45lZRQ7qJ2DXRPsfyCG00T5BHp9lm0fpN1HSeaDLVt9oM0ywYjdvh+g7fvnlxXlSBcXEkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBDMZIMbQti/hnvY9E4uaE5vrEEgGNxkwD559alVQG0=;
 b=D+umnY3f+WbON1F69a7G3YrEpafXn56t7MthAdWB8NMuU9il8EtAzY0gszMUG62UjAxlSG4hhvyvv3GU2PtC+djIcqPPQiaub1e+n+Nk4b7rUiAfmZ+qCol4jAvCbuMezbZN0iHuBe3cwGDYghn1rksp98sx0x7hTx5Zb3jx1qBNR7PjWoc6WXnHJBb1mZ+V+XFEZVuksg4JsTb1mRhKdbjofrfCOdCztlUnv9ZSUI3wSyidEcRRDmhKWMRK2n+UOWcixc0n48KhWIPj013MTGaEoQklzphkHKTTtOYnYzmmaheqFZtdH2XDSs/Dz5Oi26tF2voBh4A3y2HtnGgUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBDMZIMbQti/hnvY9E4uaE5vrEEgGNxkwD559alVQG0=;
 b=Luea3m2h4n7wimMp6CgzLPfr3tIAjpzG1za2Luq0n7PET1g6Ex4a+GL5zMDA06NTJB6DDX9g8Pj/W9NPuUzWfn1r6Yqx0ydk7xMmNBNEhu0ph26BpYXK+yq4ww0/kEcfYTex0Qpsx/PK7A/aZabBLoDOwOoszjczH2TdQ3r9HHw=
Received: from DM5PR10CA0006.namprd10.prod.outlook.com (2603:10b6:4:2::16) by
 BY5PR12MB4817.namprd12.prod.outlook.com (2603:10b6:a03:1fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 1 Jul
 2021 04:28:45 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::60) by DM5PR10CA0006.outlook.office365.com
 (2603:10b6:4:2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Thu, 1 Jul 2021 04:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 04:28:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 23:28:44 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Wed, 30 Jun 2021 23:28:43 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-235359 drm/amdgpu: Correct the irq numbers for virtual
 ctrc
Date: Thu, 1 Jul 2021 12:28:40 +0800
Message-ID: <20210701042840.10474-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a45b762-ebd2-4ee1-baab-08d93c48b6a9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4817:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4817F628A180440B96A323318F009@BY5PR12MB4817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tve5kxbsz0lzO8vREKlpW0MaYlsjD3M37DdB/4Rr8yMMe/3d+mZAgUzrGkwk92sNxFb9+JcR1MpPWFvJ5br9E6kpZcqo1zh9O08PjIstfqrMQzSVzixTuHqt7QxRJDcjyWUwpyqNRQpdjmjFfrlRiQtCM0BoUBQhmDdz49d3NfUFE8QPjZAxol3WlkHMxDQ4FIXOAo7dFqzWTs7/rlJc4ivqBk+T1D+rvZhmlu9e3kB+g8qIihfVdj8/qu2r2VyV3mpcZheG9qomYbxqQkGlChuSfQifyPfOpZYbjxYxY5mfM4tu0SJ/HZg6cxhapIhz2LjgpfNyTsc8yBTgx3XVXoO9bTKkSkxH/N+Vu0Oyivbiocktv8KZMEi2fu4xKPwsEEk3gHa1ArEfP2ZPmehbk+TNW0Ib3sXb7AFrsgod31g6wdDZHvj4qt506+qMIofgYN4n9DjeDc8nY75vG8q0XyHHbl8CLewNnhO6skERtmR1Tq8Oj9qzXxaib3tpf9wfmlK/KT/DmXOTsSUSVEyoNstAK9E0gH/KrZb3ehdFx02jRNlFrlkXo2xL2sTDflXzXwZM8RrBzy1ZBMD7f3E+AaeJak2uLQVcwtfIza+bqkfzHga6yKuBdxXOMOrm4dmjSBd5mXTGPINy0H5OurlmzyAI/xWTMyz/KXvE9gGf4hLQsk710p11MuoNp+2SejBqjld26joiYamDKPYIMg0vdTuW6+9vkbJyb/c2PrhqCtc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(336012)(86362001)(47076005)(36860700001)(426003)(54906003)(4326008)(2616005)(316002)(5660300002)(4744005)(70586007)(1076003)(26005)(82740400003)(8936002)(36756003)(8676002)(478600001)(83380400001)(356005)(81166007)(70206006)(6916009)(186003)(82310400003)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 04:28:44.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a45b762-ebd2-4ee1-baab-08d93c48b6a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4817
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
Cc: Emily Deng <Emily.Deng@amd.com>, Victor <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: I02035f65b71ec52795c3e8ae979fb582c3cce592
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Victor <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 33324427b555..7e0d8c092c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
 
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
