Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E13C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 12:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BEF6139E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 12:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BEF6139E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECB089D73;
	Tue,  6 Apr 2021 12:21:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9033489D73
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 12:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8khi7sTZwaF23A1BdOq34hsYjgWHnUUqnrkFxWxzbS18PkYPr5vY2QZ/Le0j3IC33vIX0A40haAntr4+CRDFmgSDQz3KlchTx4THBL+el966Ej2MzA46tbbiiwOlHTbWpYBaUGvI7s2gKSDV7oLovVenYOYbS7Pfbza/R4pVj3/5jIjlCEpmAuvo39KlfYSok8+m1nIadIs48wf1w9G1QSJZ6861KvBm8ZnjKeV2OFb4YAR0KYBqyo7FDuVRgVqNYeef1DtDC5a23E5VYeD+v+pBc+MNKcKO97PQvuJwgz69yKpSyzstO/jVGO+/OBNxBIdluONMrmsqGD7u/wz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd4V/onrEIio2oFhY77H0YclFTvmoDaKzRHh88aLeMQ=;
 b=LeyvKVRZ51qgErKGQ0CCylrnWmwAl/Hq5Ht+61hphchT9CHZmWU6K59IVy0zaVzhMxRimB7LTDo9cPiLrQZ/42i1PyIjFwQGv0HvPc3bzq+hUE0VtAYjNl2prhGxVephv7lcB2o+5iLT23T8hLPrE4c1yrEkTxMysuoJTwoo7/KHuiaMYAWKKs64xg5nHsMwCZw3pen2QzBGTMbNu/79ijIIKXSz//d79tkAM5VFERobjWNghNeaSUbSABD3o2sVlcj9UWM2Fscup+rTG3LIymEZLzTvwSmKujxCn5RUN931TuCl4YRtBCy8mvaiMj66pWAFfJK41QqdetI5L2Xz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd4V/onrEIio2oFhY77H0YclFTvmoDaKzRHh88aLeMQ=;
 b=0VrTnQ288DL5QeQCOXmso8SNoOT+PI73c3pj2lyFa1QMwY47lixIxUwVYSqsGsW1EQWzXZVXEfnjlfv04qsWa2qKZP8e0gAqYppx7zDIZKY2sdubjMLMSEc2HJH1YGY6cG95dBqZxHTSCVhBsUaWcPUrgjr6GGyh1zGXJUxIiTc=
Received: from DM5PR15CA0062.namprd15.prod.outlook.com (2603:10b6:3:ae::24) by
 MWHPR1201MB0159.namprd12.prod.outlook.com (2603:10b6:301:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 12:21:15 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::95) by DM5PR15CA0062.outlook.office365.com
 (2603:10b6:3:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Tue, 6 Apr 2021 12:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 12:21:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 07:21:14 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Tue, 6 Apr 2021 07:21:13 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Cancel the hrtimer in sw_fini
Date: Tue, 6 Apr 2021 20:21:11 +0800
Message-ID: <20210406122111.23989-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a500801-929f-4f64-5092-08d8f8f67931
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0159:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01590E61E2A55F97FF22E1EEFF769@MWHPR1201MB0159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIpGfY4k1Z1+gFcVjIRj0D5cXzNVELOsOHis3kYG0Dnx0QTGPLpHhS522/6iFsHYTXZw0QV9gZMvB/SWMQYcJBVQAXMyPmYtMEzXLuP0Hk+YhZBfMz1Mnqx9iX66yWzglWW39zW2CU/TEdJPV+IBMV3HPblNEtvV8gPj98MTCRkWM5gsAdfMXD/TyUmgp0IA9sWG6AX3iVXxQH4FLgEcHRCU3esNTpoetP+VEktqFBFYAN4JsoOSjLtVqy0uarNLopdyLffzUGTeB+3bpCbZl0lGG95WNisJCrVaHboRETqeonQlA6EL+XMe9/RDvJlMb/UZmzL7fezaEBGYnAFYVBmC8cdFwgJfMtKSSJyh0sht4/B4RIDJgSYWxYzkiCB3Z1uGV7KGtUC1zv/UrQUm99GIRlkdye/oqlH0VjQGZlQrBK+WlPBRr1JQLiSgp6iu9kIcwi3yPzQr5QarlDaoc72zro+SUKz8J72YoV0MxylSTNZv1pnZ9DjR2nraFRiaRL9kgTd+E57oIpkBPmnEg46Q4CNd2PETV+pCVfJMt7PnaBpNfDXC7wFkQJgUfnxwJLz4x5bEe4ZpcW1gejzoNhFrmaDRlQSsbVuBavM+UfPqAZ+wH928YnHPgqGStNZtTez7LM47vgkyKHuiR3q8L5gtyAL4kxO9LREOGWPGe5kf6+gZ8YZ1p/kapw55GBQt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(36756003)(6916009)(426003)(8676002)(47076005)(4326008)(5660300002)(356005)(81166007)(70586007)(70206006)(83380400001)(316002)(2906002)(82310400003)(86362001)(8936002)(336012)(26005)(7696005)(478600001)(36860700001)(1076003)(186003)(2616005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 12:21:15.0903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a500801-929f-4f64-5092-08d8f8f67931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0159
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the process of cancelling hrtimer to sw_fini

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 5c11144da051..33324427b555 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -421,6 +421,11 @@ static int dce_virtual_sw_init(void *handle)
 static int dce_virtual_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i = 0;
+
+	for (i = 0; i < adev->mode_info.num_crtc; i++)
+		if (adev->mode_info.crtcs[i])
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	kfree(adev->mode_info.bios_hardcoded_edid);
 
@@ -480,13 +485,6 @@ static int dce_virtual_hw_init(void *handle)
 
 static int dce_virtual_hw_fini(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i = 0;
-
-	for (i = 0; i<adev->mode_info.num_crtc; i++)
-		if (adev->mode_info.crtcs[i])
-			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
-
 	return 0;
 }
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
