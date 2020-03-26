Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4FC2D0E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2CB206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TE7zCvq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2CB206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A006E2EC;
	Thu, 26 Mar 2020 20:03:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DBD891F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 20:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXPerLqaFIC3B+3IdkRgJaryvHkmzeK1zbP8/kmVQHIJGDHUfYf+vr5jMWnj9wXmULDdZ89+IY75DpKbcI6Nf4IymKkAT16VQkTkIjrXKXsS7pzTF8dOD1vEK4WTiHges8gQ/5Hif3iqeeLY6dbkvTepEQGhRhYgkRFZkBwSExShWdWk4wdrBng1izrvZe87EZKO0MdnBIpMbWFkWw9L0AaRu+HObD5Z92q0nSjL2++ljyC9UpavbVr/wzmsv+WCX653CDr1FHgbd0Ix+Itr1rjf8NQV+pWO8fQD6l2dH+wJ64uzPTFxoIgebMrlrf+PEwCg+Pst3tAP3kLs+DxsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cmc2U8Ndhbie7vcUyGcpKqllNflGms6dhvHMyIWuzM=;
 b=a2CHfTlD09Zl8DRpRYze3BoZWMhVgLHzQVmY7qM4ou6lyrw0QzhAtFeoMhSl5ub+OSEkC6adkwuHKncVrL2XwIJezul2eNnCMDbG+8PrOOdz5auH/gS3k63don6aPCqC8bfMAPeiDVqBCRPNeWC1uATqWyyhJ15gN4u0YZ9WKSzn5Rgm56jbWL9fyT7dmTBgLpDrrdnOVB4ZzbGgUuqvppqZQAU0j/wEVSx5ELpnw88QlauKggVNcbXPlF07NVPKc2gimBT8SX06jfEbrUTdYMID/7iW908tcCDJNYzQYUGfT5HYRyBDp//FgxbF850W34M+CgHouKWygyj4xFFNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cmc2U8Ndhbie7vcUyGcpKqllNflGms6dhvHMyIWuzM=;
 b=TE7zCvq8NhY7/kjJcfTIhQMVmPtdQKvRjdtVqqLzSS9b8dBDBaZjff3099S9OTsOq1A1cLdzpLPCLvnN05Hn+SJX2961CU6hfLo9dfbZYtgsshDS2BxuxDPdQgULudMOG52o9q4wAwLCITXYmLNwfFNx8MlyJO3B4ONo1A8lFn0=
Received: from MWHPR10CA0058.namprd10.prod.outlook.com (2603:10b6:300:2c::20)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 20:03:01 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::92) by MWHPR10CA0058.outlook.office365.com
 (2603:10b6:300:2c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 20:03:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 20:03:00 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 26 Mar
 2020 15:02:59 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 15:02:59 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/4] drm/amdgpu: Add new ring callback to insert memory sync
Date: Thu, 26 Mar 2020 16:02:45 -0400
Message-ID: <1585252968-1218-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(428003)(46966005)(478600001)(4326008)(47076004)(70206006)(82740400003)(70586007)(8676002)(5660300002)(86362001)(6666004)(356004)(81156014)(81166006)(6916009)(8936002)(26005)(54906003)(2616005)(36756003)(426003)(186003)(336012)(7696005)(44832011)(2906002)(316002)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0160; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e4c9c6-2d76-442b-1413-08d7d1c0af97
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0160:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0160732C9F664A7EF9C0EED2EACF0@MWHPR1201MB0160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0354B4BED2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Vn2H/ucCT2yALddoCMVaIkgiGnVQEW6ujXH2Wo3DuV+EpByF4V7fDhSOxcYFjbjdgtp+vR4ZGAdKD7Ib1CIyI7H40ogSGjwFP1gn5CB+xIeJAtyDgfia96Q1X6U1fT1ERXKWON274JIQRiZnKBgvr44/utPoZhqqvsPg0+iBxK1SMm5DbAhN5TVTFcCBcD+f5EM6AGmAGDULwap43nZDRxDuoVFlkRmkEv8BlzSTQvDSyB1JpHA1wuGQ0L4bzFO01RqoV8sJTod4mOox5qrJFfH1XDEmc3lSUZpR+CHZmlRt85Vc1FEkMGqHEZrodTwSmkP1i1KEWxk7sQVWlmo5ZPGWx88KPxyzhUjgVKpks49jCuxtfT7HDAPQXU0neWXrxoPK5nPwcYqLBA7gxgtAIiOK6p+C06nezOM27hTJZD44pYnyFQlLfXC5CBJZ2ImAKOfijibLQMBIOkdheXiQhLJtzTL2OPvx0vy904tfQPLOTMEISlU0gWYZxIdIcJTmpKJQCACK03G06YYFbABfg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:03:00.4345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e4c9c6-2d76-442b-1413-08d7d1c0af97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 ckoenig.leichtzumerken@gmail.com, Marek.Olsak@amd.com, Ken.Qiao@amd.com,
 luben.tuikov@amd.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to flush and invalidate various caches.

v2: Raname function hook

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 448c76c..080024d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -171,6 +171,7 @@ struct amdgpu_ring_funcs {
 	/* Try to soft recover the ring to make the fence signal */
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
+	void (*emit_mem_sync)(struct amdgpu_ring *ring);
 };
 
 struct amdgpu_ring {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
