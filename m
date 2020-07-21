Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5915EC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45BA20717
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ikCvSnzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45BA20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6399F6E0CD;
	Tue, 21 Jul 2020 07:39:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469916E0CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 07:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZdF8BBLUTuTNtPtf2BPnSiEM43MOTzedSF71dKQ8mc5PmeYsN45FlGt5e9FngjUeIYsZtzrIcXItJWcbA9WbbepzG+Tu3tyQcgtu+U8QjFRARO/ShjbP+zfpB5iRjTyiJzewAxyiIxDpGJgcfa6d30aRxwt9jUBTOVtz948n5kQwcb49frrShmXtG2w7X4GAhqtsdwE0YHRbuQ5G28UOIIWFRHtVCl5UPfyDClggFCVGSkG9FtRAXRtQNVAKULZjk3RfQS1lmYiR71l2tnJxqUM/0/NoXrLgJ8h3cr1V376MJVXzfnb1uxsKC/AOkWg15LZpxE+qVgkGHxefk1EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp9TPvV+Vxn0BSAwFpSgH0aF0ErUbbeoc9c7xXBBtfQ=;
 b=YHW1uSAe1lGu2VkMxLyHipOSC9p4vPI22oyGDt9zfanmiHAx3rEQ61x9povE5RYbfwjd/j171AJv4h5qeJ0NCgc9Kut9XHRhP6O1GaNDlfa6g2J7DEBU2qKpsWMk70TWNQSAhUsNJRsprOv0Mqi1kPNk5+X6OF1/r+yRl1SbJbu6BzBLoLqc+bU98+MEnJl0sAPqRAkAmFz0NHv+54W1pvpJxRYlyBi5c9BYUSkWZgPUbvQT/8u8qgA02fDyxRCImNddMqJ9f7RewrrxKvDV/3NrpI4ISKaEav34nhEKnp4R6ib+7c0Xn+gfpTpwBAs90nFINzAafb1QSviQRDM3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp9TPvV+Vxn0BSAwFpSgH0aF0ErUbbeoc9c7xXBBtfQ=;
 b=ikCvSnzNK/VFGINQDSxc9UKwFcQ+a2wly4J9hdfrHPaaV+5e4l/ECN5psz8FULwKdqZ8bTSHL8t+LuBDjguEhAhK9PahiLqXcIhA3cBtpxNPL7Ph0dRTAXTDyxeoBQLxAuRoP1EWWPlkX/YO6O4PTKBSs69+ygPJxuU+0yzHlY4=
Received: from BN8PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:d4::27)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Tue, 21 Jul
 2020 07:39:17 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::5c) by BN8PR04CA0053.outlook.office365.com
 (2603:10b6:408:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Tue, 21 Jul 2020 07:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 07:39:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jul
 2020 02:39:15 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jul
 2020 02:39:15 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jul 2020 02:39:13 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: update driver if version for navy_flounder
Date: Tue, 21 Jul 2020 15:39:05 +0800
Message-ID: <20200721073905.5041-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(26005)(70586007)(186003)(86362001)(82310400002)(8676002)(1076003)(70206006)(82740400003)(4326008)(47076004)(478600001)(6666004)(426003)(336012)(2616005)(356005)(316002)(2906002)(6916009)(8936002)(7696005)(4744005)(83380400001)(36756003)(5660300002)(54906003)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8474953d-a70b-4b49-ed56-08d82d492c12
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25448748C36AD7A4A438AA03EA780@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZ6+m/eIRMs9cqQlULaHGKaSr4rmX0z72grRcPvo+yFvp19o8EVBZX40YnjLKkj2ZOdV4xQSW5B60avNB+IRmALU1G1Tu/SjbwrfNuc9GkeyM3RVEiX5Lx/ryvltpEwZ23agPg2w4/G7jdc/74uKYWDJnxUHxYD64uKz6vIxa2Ga2azFeMfkcPqroQJLiTUjdVGCTh7LA82U3pANfmmGc7h7Rxd7l9JiLEN+0bOlxIrnZMF6MZ+ot0oawUQ2T7AjV0htGJHt3YPURR3ChiORGmzBKXeyafP1peXnygF3+ZN8jBvbGp446V9OIE9LlAHJDfhk3MLn4NAIwB/SCOijFqdQNVCpI5fOcTv9Db4fJSWKhRvRU4ZuCJqg2ZlE54EpqBO/F0qpyOcmEco+gNcmvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 07:39:16.7356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8474953d-a70b-4b49-ed56-08d82d492c12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
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
Cc: Tao.Zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's in accordance with pmfw 65.3.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I97b0a28e280c3ac5c63f9c17a47c08b2c9b7d65e
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index b18ee5837f50..429f5aa8924a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x33
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2B
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
