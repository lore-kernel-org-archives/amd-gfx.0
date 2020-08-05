Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A010C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7018D206B6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hvHtM8Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7018D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFA06E835;
	Wed,  5 Aug 2020 17:41:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAB16E834
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq4jYttRP2Y3lw+i8eyEBMDXVnwx9bTwfKF2Z94ZacZgiHy7c3pPIEty0TR5FOu8GQBJR8pEKUIvfZkKk7Sot4YG3Zur07mcVnezYWk7UVDusHubkNdbjF3bY6LxHz00TaDgmmPAlh2SBW8Kzxwy4sICC0T0q1No9X9xXYzvc0QNz0/bFYHoM2vkE1nptBoieeWrkMznSwqNd1ZB5t+6o8QJuhgockgPV4zgpRQ4wfWt/eEyHj9rDN5bUOOPWSCKEgf+8bMFtAn80rPL30LCi8i2zDZ52UEugmlDX7SxcMF/Re+SEpGCZX1MlYyyKV1C5qz+ZNg0xSEiLZfpembUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Agzt7iNk4McnaR2qaWLxRdiBZiGx48fk24De3KGCw=;
 b=dBD5GFHdcfVV47YxuGKzhY2uCgqpCwY7pASEhn7OnAfdeQjt5ST4hnPNyWe1+LU5xODhThDwkWGJUQKy3GZMX9cJGShpx2Psagilg7YT5ujKZrFTFWgTewwSKwqKESUPZiJUiQyfmh+5I11GLafZe/bfz669pRp8cNDYddpaVoqQSTvlbeJ2U2nZKJT07XrBytaPM9jJwUA7mjEpfw1Duy4gnoBm7DzDvgCcRqVldFodWrtO56t/m83OfwLVa8d8xI2uRAXtnPWTdAfL4gtW7oPOqTP5DcXGFfjO/Saa8ODNIF6jgFZTAvDHr8ElAci6FN+WRayVnI8bJv2RdUNSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Agzt7iNk4McnaR2qaWLxRdiBZiGx48fk24De3KGCw=;
 b=hvHtM8Mez6jh2Vgp1j1vssUGaBliQvB2JPPW10e1IvXLOzz4cqZpQFqqce6q0h4HVcBiYegzktC6JMKZ9Id39MfzHHIW4KnLFs6Aj8vmiSm0onp0Y1/KqHqgKRLleljDJumHgZyTsQhrvQqRxC3xt/teWRL8hzIK2p18MjHBeZA=
Received: from CO1PR15CA0084.namprd15.prod.outlook.com (2603:10b6:101:20::28)
 by BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 17:41:10 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::c5) by CO1PR15CA0084.outlook.office365.com
 (2603:10b6:101:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:04 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:04 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:41:04 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amd/display: Fix EDID parsing after resume from
 suspend
Date: Wed, 5 Aug 2020 13:40:57 -0400
Message-ID: <20200805174058.11736-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805174058.11736-1-qingqing.zhuo@amd.com>
References: <20200805174058.11736-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ec91160-9ea5-4304-22f1-08d83966bd66
X-MS-TrafficTypeDiagnostic: BN7PR12MB2689:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26890BB987CF58483792648AFB4B0@BN7PR12MB2689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGGYivWKKlIEWGhA98DmnubVK/UGAIScSD6ovmB6OX/I2pzcXldsudfnwoNn97AM8CNZFhnelfl2yEP9pi3j6UBgAPC3tiJ6LRkDmWe9bcSUEbFz8+eaIPGTxJtATs3DkjPjtNbsSiLnBRkM8cL6XWnFirB01MeD2/SGUycwOLkjOscOeL9DmM18ezAQOSyW1mQd09ctmxloUqCatPjPEBqnQgz7ouvjXmUn8m+WPGApKxaC/rz8JPdP+pAi0HB5IhJLF7KaA62dcvmZ4hwSE3pgFUGWgACH1W4iStDjrufWshtLaXmV3KiiPXLaMyRQQBHqjm8xAzJtY1Ed+bEsYyGJIUDLB09NLd2mTAErA8FCt3RV1Bxnt4lU0pDluE7gtA2XVmzD62yXsBkHn02S/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(8676002)(2616005)(82310400002)(1076003)(47076004)(82740400003)(70206006)(6666004)(83380400001)(6916009)(316002)(15650500001)(186003)(5660300002)(36756003)(86362001)(81166007)(54906003)(26005)(478600001)(426003)(356005)(2906002)(4326008)(8936002)(336012)(70586007)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:09.8330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec91160-9ea5-4304-22f1-08d83966bd66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2689
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 stable@vger.kernel.org, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Resuming from suspend, CEA blocks from EDID are not parsed and no video
modes can support YUV420. When this happens, output bpc cannot go over
8-bit with 4K modes on HDMI.

[How]
In amdgpu_dm_update_connector_after_detect(), drm_add_edid_modes() is
called after drm_connector_update_edid_property() to fully parse EDID
and update display info.

Cc: stable@vger.kernel.org
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53bf8f60d30c..bfb06c168fba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2202,6 +2202,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
+			drm_add_edid_modes(connector, aconnector->edid);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
