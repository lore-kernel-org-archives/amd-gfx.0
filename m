Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9457C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E89A22AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E89A22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5346ECF7;
	Sat, 12 Dec 2020 15:47:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9456ECE7
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9Hp1gkHFzRa5ltyCYActKfzLpv1w/+Kcvn9ghT8cAgdrbpYcPnp4s4pScBR/ptZqbRo3qYjuF6ljoA4t3KU5V8E9F2otCYU5m4hPBO6yl9txb+lA8nSp5KCJtR3TAdjWgYRruKu1OUZ7HonQcJTCoVyT0TEY+i/MlyBhtxx6KjhlzcExGM3TFLZFD8HbdCNdlcK/pcwUqBYzCmKq9LfS9SXBI2sf79UOXrQ2RJG9M0GanFKaVSQpIKCBXmPZ6aPnfizdKvsGN782dr+rnCNR4/v+vPKBK3gPRYbwXInN+1Le4p4ukybkX2YwgHMHwmAE511QVAZVP/6ExAnZdhiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueI+3t4xyE+ewQWeIrEJQVYC0vD+yiVLZNdbaTIgP30=;
 b=E71XehMmsAPWXc2E76SdJG7v9d+4Dt2T+BwDVkOh2ZcCf3LrmGnwC6xw31jCq+EGFtOZX0q1pAMEbls77AExliJUivGnwP1Rj56LF7225x4wdr7LkN9tJ6nW/GnuLgUeIG09GR7UCwIzSzk1vke52yZVwhkJBOP3rwgrz0jlzjKOrjL5A4d/t476SHUMwB7gsCrMziuEWwdKUV5m1YHo4JaJOvhh49e4XElkHL++fRCtV/WozmxHoHP/gIvbuvBkYyp1YqAiEmj/yjCv9CcebqA5/SgF/LcfnQzGAhfHrcchL/ipMtGVw11wHn9bcpqc7dfqAuYW2mxPBN0iu1PyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueI+3t4xyE+ewQWeIrEJQVYC0vD+yiVLZNdbaTIgP30=;
 b=GMcuSDppYOp4onvMK2s8vlHaDIbXK3Y/svUG+BLZGnjw7zRr6jIF85zhpZX2lTyddPY4seZ8d3JS7TL3pzQ6fghdm/so41CVPqpUa13XVRCS2CFjVVKNf6cxQCfbxfiSOHgGlQPsAcK7zP6/hlQnMPzmTbPguZGdGLaxCNAbaoc=
Received: from MWHPR04CA0060.namprd04.prod.outlook.com (2603:10b6:300:6c::22)
 by BN7PR12MB2644.namprd12.prod.outlook.com (2603:10b6:408:2d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 15:47:47 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::2e) by MWHPR04CA0060.outlook.office365.com
 (2603:10b6:300:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:46 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:45 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:43 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 27/27] drm/amdgpu: don't create ih ring 1 and ring 2 for APU
Date: Sat, 12 Dec 2020 23:46:00 +0800
Message-ID: <20201212154600.21618-27-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fdc2092-a033-4e95-6e51-08d89eb545a6
X-MS-TrafficTypeDiagnostic: BN7PR12MB2644:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2644F3A0113EC3C115909C74FCC90@BN7PR12MB2644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scx0c8jLaGQDYphYLP6Ba6cNn4VVs7d6Qdg4vAol6T6yTuFsHyIhFIfZzH0ELytcb3ApiKDABAsGNjflcrjT5bPRykCe4ZmgOcZgOvfXNerJfvoArlV87IDzYRRKXdDPMht3JQz6vWvMZCv3cAGBg52xpoNwSuRuoOWQTj0YpTJDYk31xoFNRXyMI3fvsbsjN6F2Jo06Wm/jwHbJb/SXegEQzNOiiQUGwiRVkxkj3ftHTsxoYW84E46P4FsLj6wc4Tj1uQQrSJGGgqbqKeD1fwJ/4utq1ULDlGUeRF48barQM21/uH0Khh1J9Tb2ALnUZA4Wo9pzH+Qtmdh/Pm2AllTitFZ4BI/x2jvzjyY2NkcM5d2Iuo7hq06KGbo+Dnib63rkJitzNMj656R3G0hJjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(46966005)(8936002)(2616005)(70206006)(70586007)(336012)(47076004)(7696005)(426003)(82310400003)(508600001)(26005)(4326008)(8676002)(2906002)(6666004)(356005)(5660300002)(1076003)(86362001)(110136005)(36756003)(186003)(81166007)(83380400001)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:46.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdc2092-a033-4e95-6e51-08d89eb545a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2644
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

APUs don't support ih ring 1 and ring 2.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 44021efe8222..b1d94421c8d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -489,20 +489,21 @@ static int vega10_ih_sw_init(void *handle)
 	adev->irq.ih.use_doorbell = true;
 	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
-	if (r)
-		return r;
-
-	adev->irq.ih1.use_doorbell = true;
-	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
+		if (r)
+			return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
-	if (r)
-		return r;
+		adev->irq.ih1.use_doorbell = true;
+		adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
 
-	adev->irq.ih2.use_doorbell = true;
-	adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
+		if (r)
+			return r;
 
+		adev->irq.ih2.use_doorbell = true;
+		adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+	}
 	/* initialize ih control registers offset */
 	vega10_ih_init_register_offset(adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
