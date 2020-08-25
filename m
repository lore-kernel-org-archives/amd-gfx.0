Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388FAC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD842074D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JGyyjbDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD842074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8252E6E887;
	Tue, 25 Aug 2020 07:58:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31F06E887
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3fpq+VtZ1S9daaxnf3fM0IL6jpD7K/B9Ag5cMYcN3b9LnFmk5DBFB5XAhkoWe/mBTo8BKKamhxgJZA3DhAv7KdyjgTVcsuxFWc4QoKrr20qDqsOpSuUuvO5yN8BbhOW+VS0bgW/DE58mOEVw7efBWGr8j5CSSx7RQm9HGmP5e7ZRNpxy4YQNbVaXE81JdIuWB3YB+7wPacxG+nB6Nd4Oyt+iZqGdDe8paMbiqiBQowdO47d2XH9pVaNUt2r/zHscoFoIwWb7QjaDWcABP/x65CPutYTsr7m7PvkOfe+2cnJu8Bghlzmuiv+PHlTV2zLD/Q5qXzUojjopxcs4zL2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZINsKY1SLGBUcV7aQZqqrqt0MxEjNcwZiXRdCawrzc=;
 b=H9fvPZh1IodZ4Fe3e8CUVLnZbgdpzd93GRaPHYUAJudo/MnNT4uNR+iwvESpKLwBbug37CKVOW38MKbYHshv3dl8dwxvDRTTo4VFQCqoPNILp/KoIusAJF4ZEv01RpZxJSFiYiYgQuUJTzH+3jbczoYZgfOC4Vgyymcde5J7x36qguF5qcyeaFqNMxqXevhDXSM70J4zujuv/EttBaErf+yw9HupJFwq/fUuU2tSVw19mxsR3cbrre5vAeEyvRjmTJeebMOWXSZu5rdmC4qoWudXJB1ongUhGT19UE0OauinvW0PKs+PAHfgm1878N0ASmuzRFBCxCLT7ZZQUpYahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZINsKY1SLGBUcV7aQZqqrqt0MxEjNcwZiXRdCawrzc=;
 b=JGyyjbDdjljsCV0wxQ0wVRu7Uje39Uk20J/UqMLzRy1bhVTX5vtF1+cRjPisaUMaUoLX4ucVeCLV8/7mlVT2zTond+ITm41DaPHRe9y1mFBO40eVL5u3uvmt/RIY4FqNiqRbhAgAATxkkl5up20Ro2scR41EMvxDuXxU5HAAJA4=
Received: from BN6PR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:405:4b::28) by MWHPR12MB1902.namprd12.prod.outlook.com
 (2603:10b6:300:10d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 07:58:49 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::ca) by BN6PR1401CA0018.outlook.office365.com
 (2603:10b6:405:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Tue, 25 Aug 2020 07:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 07:58:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 25 Aug
 2020 02:58:48 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 25 Aug
 2020 02:58:48 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 25 Aug 2020 02:58:47 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use MODE1 reset for navy_flounder by default
Date: Tue, 25 Aug 2020 15:58:36 +0800
Message-ID: <20200825075836.2142-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5effd627-4726-40d9-a3e8-08d848ccb330
X-MS-TrafficTypeDiagnostic: MWHPR12MB1902:
X-Microsoft-Antispam-PRVS: <MWHPR12MB190217168D0943E5B09D5ACAEA570@MWHPR12MB1902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4avt9AcXnsxu4K5neTKJjsjsyH6GFGdytAWLh39qo/LTevokwvWMdvY/ZTA0mAWPEBvv/jjNV9gcQj0OLT835cz6z3RVnt5xVw8NzLinigOfWiUAVSaQJI9oB46YGh9QelsD9ZFl64KFLDFrNcD+DyEL87r7Chawl7vvGHHtGWxfIPKzxpz4sq2D5kVzlPIjHxUOCDfdmqKJynk7A6wUys+uVO0KeC1Cjz7+n2qxID0TkVFpblFa5nyF1Ch77TOYzrWdZCXc6atG2W3qvF422WTORZrXpr3MkOTu1+96u6hybGzcMlbv0q5QbBZdBNDuLeTD23U2w6ZPZTIHcaLxeQXu+A4vSJuCVgSI7VtxmsHoLPIxR/s6lMpdG0rEO6hnFRgoSYttIULj2q75AcUmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966005)(4744005)(1076003)(478600001)(316002)(36756003)(26005)(47076004)(5660300002)(82740400003)(70586007)(70206006)(2906002)(4326008)(6666004)(81166007)(7696005)(86362001)(336012)(8676002)(54906003)(2616005)(356005)(426003)(8936002)(82310400002)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 07:58:48.9343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5effd627-4726-40d9-a3e8-08d848ccb330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1902
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch default gpu reset method to MODE1 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I99b2d3ac04352142e288877f3b6c3138d0efd4bc
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 33a6d2d5fc16..4d1402356262 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -364,6 +364,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		return AMD_RESET_METHOD_MODE1;
 	default:
 		if (smu_baco_is_support(smu))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
