Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBD7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 07:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD1A207F5
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 07:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uuKF1E3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD1A207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA446EA14;
	Fri, 31 Jul 2020 07:51:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392AB6EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 07:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8+pz/XRaZ++GBmF1NaQ6Dha7/cPLcWs63+hPqACZLfwU5orkCOt8/ASxMennkIOyi+jyPquQcZ18HBYpvM1G8vXURygZFy5adSTRHFHqXD1dek+IK8TAMfHpGhVgjIUdbgM26+q76/9QYT6Akwum5UKXTCzdyp5L8bBLP4DM07gyebUMzTcmNIk1/0EiulETaa59OfkH1vHxv2CKB/CdcI8ytIQ3tg7MhyPMgFBv1yXQWtSY+NAyYxxfV/fgKkgLJDBgll3NNl51Un0TGdinw5hucF95rn4r972lNNnNIR7AsENf9XZLFt9LVCuiH1TUot0AcM3VgP+Uy69vDGO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywQ7ljVqfywBjifAz4n1rOQsHNmdD27H22ARRQpTcTk=;
 b=TF61S+4REUWiYApcN5PNjCgJcttb2G5tdKvT7CP4rJgwvMxlCiZ5oVv75vsOVX0g/vG7sekILH5q2o7+OlGS3N8bs6qIZycjTFsl6l8sOzeiXSiOcuTt4EI0Dtvn6muwpzsQyBmOddPE15G4trKdG++pTzgDB2anVlk7Fwwl8yzjueYNqGG76qpJlquAl5NTiQ819h5KhrMOTrgS0dNntcjCejafIJxWC5x3sbgxaPlLflKNMqx45sCjiYCw75PVexQ+ENLNBn0/Pb963ed4160JmjWbF0fFyfVtFGG3Pu4aGBT6hGjcSmJZkhptdEIIz1pI/5SvPwZdaHkBFQRkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywQ7ljVqfywBjifAz4n1rOQsHNmdD27H22ARRQpTcTk=;
 b=uuKF1E3lvFKUfph5eRVkXkYt5VplTT3qHX7fC+frQt7WABj2sBMzjqdpTBSu8fnfM5tds6q1Pc3xEuCyE5I2gDjQ6CeNfPXYBlyxBIPTLjQActCm13EEK/9kjDEdHt4DlhY+iy7gMuv+rGpA5/kcainuUm/Ocvm7es6l30uF5aU=
Received: from BN6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:404:10a::32)
 by BN6PR12MB1331.namprd12.prod.outlook.com (2603:10b6:404:17::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 07:51:12 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::85) by BN6PR13CA0022.outlook.office365.com
 (2603:10b6:404:10a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend
 Transport; Fri, 31 Jul 2020 07:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 07:51:12 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jul
 2020 02:51:11 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jul 2020 02:51:10 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Date: Fri, 31 Jul 2020 15:51:07 +0800
Message-ID: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad6904a-76d2-488c-219e-08d835267ec5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1331:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13317F68BFD7C8E9E95D2BE3844E0@BN6PR12MB1331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt+Pa9IoZ2NsHOhSbRbYDcpRy7uTKViWxc37OO/EMamT9FOTVnAbkp0mZV2aNtdZkYS+BKAZBI4kRK8P9YvfyOLpiB6uOsyFATMnIY3vKSD+UbMSGNZfq5psaNtfnJgkGpHNppBIyedHuRra1q4YiBOqgey/crWhJLx/j4XRuaj//njHimSeRbFMNLJ/dsCUQspYFsG3hkLbH+cj7WECysd90aM1DSeLAGX8c0tdcERt+uJj0ZnbP73zKVRDd1dIJXyUWt1dw0T//LDbD8WZs88XR7icXLzyp8QFBuchlZDbi8vtMXsJOKn8ECxR2flOtSEkI9bX1qUOg6pw/mHaaLmwYTneoc9rhSl5O6NGQa/rizW7vdVPmrCLO3qa+HQMEpC/ZRR9BJEngVSF4/2r4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(8936002)(82310400002)(356005)(478600001)(26005)(2906002)(83380400001)(36756003)(186003)(6916009)(5660300002)(70586007)(47076004)(8676002)(82740400003)(2616005)(6666004)(70206006)(426003)(4326008)(7696005)(316002)(336012)(81166007)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 07:51:12.4363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad6904a-76d2-488c-219e-08d835267ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1331
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KIQ will hang if we try below steps:
modprobe amdgpu
rmmod amdgpu
modprobe amdgpu sched_hw_submission=4

the cause is that due to KIQ is always living there even
after we unload KMD thus when doing the realod of KMD
KIQ will crash upon its register programed with different
values with the previous configuration (the config
like HQD addr, ring size, is easily changed if we alter
the sched_hw_submission)

the fix is we must inactive KIQ first before touching any
of its registgers

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index db9f1e8..f571e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6433,6 +6433,9 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	int j;
 
+	/* activate the queue */
+	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+
 	/* disable wptr polling */
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
