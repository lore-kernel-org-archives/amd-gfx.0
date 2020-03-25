Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D602C54FD3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10DD206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jLO5SvMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10DD206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAA96E0F8;
	Wed, 25 Mar 2020 03:58:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870196E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCo8ppSErAvxyPhfphBHF8aBnx+rqUVnVC25RBiCd0DUQ2QkNMQ8do7Tyag6wTK0JeG23TsJmTfvQbJaJrZ4Z9ChKsGvtRt/mQ7L/YOiB+hEpy6lUMsbGUSe1cak6Lrups9P6VkGxIQT4BEA+pIc77CdL+eo8Nxi45N4Kqi0RlQZgyKfYuCir5g1kSlr6QPXr/fdynwOY99Rqbbe7LEkAXoIhVrlfY7n7jhRVB7txihonVST8e4KI1JXKExqHt0mGeAQ+nGQ13L89Lt6Yaf0HdW4IntUzekQqa7A5Js1ASLD50x6Ecaee95lPHzBm8GJxDnHrvPO/MG2dpJghVSS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCN4rk/lu+840hI2T36CI3xfuIQDhdXrbEyU/z2JA6k=;
 b=G3ue/D1qWQBNHLg4y4bFUvtx/tvyZgFNV/zYleymY7fP/kEIGsbhS87RQo734LJiVCpFJz4IiXtV+SyV3CSW+mTh6C8zEABAJCTcTLOffrqAa3290Ciw8KZEAU0oVbViJ4/VRRJwCgav5Qf+N5RbR2F8gUxEN/GzTyUlf66D8BaVna7KBgUXn0WQIem/kmLA129evbSOBJOUYVm5/yFpxFoyYqOLMYpw4W/Hjop0V+dY8XMSQp1oislu4dqaY5Oqd+s5SeEzLG3vylUnAZo3Xk4UHC7XXuHwkPMIX/n4wYxOXfQ0AOGwR3s8sZ2GCNNue8pBtmhfhqlOli+i1Q5WaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCN4rk/lu+840hI2T36CI3xfuIQDhdXrbEyU/z2JA6k=;
 b=jLO5SvMsNsPyG4p6jda3o0VtbCm4LbMcgy+h5AHPy7LjLDBNPpmKOiyqjKfoWNIuwCAY34N08N0Vf86vE8JsVHV3G/1K5TJB66J0pLUfU74pfPuRH2b9AhzfGHWomRNIrT8oqZaBsykUWgM8foZ8mqgHyGFKfzwT0i6GU8X0JkY=
Received: from CO2PR04CA0187.namprd04.prod.outlook.com (2603:10b6:104:5::17)
 by MWHPR12MB1213.namprd12.prod.outlook.com (2603:10b6:300:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 03:58:50 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::25) by CO2PR04CA0187.outlook.office365.com
 (2603:10b6:104:5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:48 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:48 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:47 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: introduce new idh_request/event enum
Date: Wed, 25 Mar 2020 11:58:37 +0800
Message-ID: <1585108722-19098-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(428003)(46966005)(4744005)(26005)(36756003)(86362001)(82740400003)(47076004)(6916009)(2616005)(81156014)(186003)(426003)(336012)(8936002)(8676002)(81166006)(70206006)(7696005)(356004)(316002)(6666004)(4326008)(5660300002)(2906002)(478600001)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1213; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e1f34aa-e203-4cb3-b4d1-08d7d070d323
X-MS-TrafficTypeDiagnostic: MWHPR12MB1213:
X-Microsoft-Antispam-PRVS: <MWHPR12MB12130D6F9BBEDAA2C363124884CE0@MWHPR12MB1213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vv0JrqDNX/278DNHPzW68Zk0myezXAxh/4vZHT00UN3pYPFs3axYwdsr3umqoukyz/YyNdTKT0bHka49rZbQUq1EFjjpMeBxBPZhJIxRTXOMvj/D6Xs5ttvBz+qbPQ24BKS1w73g1Wm+1kCwYh16rz5+LhW71JJoNdTQ4ynmBTKUl+tlzn5AKaXxUsfMzwHDf3r9LPHoGH0bu49yOCNCLQ4p5tMKlx5pE/FzUFYstR1w7rB5krMq5CrumSGMfWR0cf13vPx/Y8+rqqf1bzd2v77W6WG3HXTNp4ploqQiqhxyv0biSgvd4aGbnet/a3SCvdC7yBGX7a6TDL3B1CzhoMsLhNfg4cRS5kMvPTNep2M371AXnvkVPOQKuD0AhklhVBPN1Dym6+l6JjouZa6hYwowdhN2BO+yVCcsVc3oNJiMrfTUpwQ/0UjSPcFU0fLG14BeTlhKPoE0Bpebl0VM2Fd3aZ5BzBwgUi/UZCGFveWUXKLm0GWbuNcJk5TOGLSquaGlOkBcG88E7utOZ+RY6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:49.1882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1f34aa-e203-4cb3-b4d1-08d7d070d323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1213
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

new idh_request and ihd_event to prepare for the
new handshake protocol implementation later

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index c80bbc7..598ed2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -34,6 +34,7 @@ enum idh_request {
 	IDH_REQ_GPU_FINI_ACCESS,
 	IDH_REL_GPU_FINI_ACCESS,
 	IDH_REQ_GPU_RESET_ACCESS,
+	IDH_REQ_GPU_INIT_DATA,
 
 	IDH_LOG_VF_ERROR       = 200,
 };
@@ -46,6 +47,7 @@ enum idh_event {
 	IDH_SUCCESS,
 	IDH_FAIL,
 	IDH_QUERY_ALIVE,
+	IDH_REQ_GPU_INIT_DATA_READY,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
