Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53073C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F802070A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DteP0CWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F802070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24AD6E86B;
	Wed, 25 Mar 2020 14:29:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BF36E86B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vygd10OGkgOw9EVrEMtdg7O3zqml/1USJP9f7DEGb4o9O8oXNjevNiUugG0rfsmOZI+oOdkFG+e+lq2HcyiNLOaiMsyQZT/tZd70GKXjZwIr/CVGF8StsYHREchIRrVBOD/DbkkAPVJxBnIeqa+XZcc2OZtEy3ZYyjXxIDWf4Ki2z/eeB0vgep7huzgbfcRqVKP8tBOXiDem9WCKdauK0X84GHYLa2I0GIKrCmDFdtF7BnZH4+jR19rJpqZQC+QX39itLVxdHmfybdTHDTYFEo2SUDtoV3odyH7o+pPYlDzNs7l+nw11Mf25As9cEDiCK3rUbRZUUaya7izgjapkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/NE4mXnn7DJX9kzlxt5ig1HNSADi7q1d2KwcI/jmBA=;
 b=Msv6nn8WtjJRWsBmmzJxD/veRb1fVC7KUauiVw2awXVxlvMxMBxZITZseIggGStSawGbsot2z746CRjtaSi93HUxV3SL0oGfxHQBnuEDBU0+qGOB7SWPP03K3raouzAeLWm6tfUUqZT6S+KkpBbnUGJ0hvmtxUkC8HZm/bHqI5XWE/HqRFytHaSX+L7zdFaRHVuds21yOFqmpi5DmooDou6+/eOfQcMpj5ELrb6j+YGez3Izg/Q+eQoxb5h6hbeQN0pzSF1SjUMegm3bbOX/moKCyyiBVedQwoNur2HMwz2Cn9xGMAc7br6uABIAnmrV5B/pU/+L37Vs45q/HwFQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/NE4mXnn7DJX9kzlxt5ig1HNSADi7q1d2KwcI/jmBA=;
 b=DteP0CWTUDr4vhL81xQyFkXxIqVno83KQcEN1OD9jGVBYL8OOkSzCro7AQ5qpNdJHHj6onZrcsGhtN9v/WYxj7cUswugQ7paIuYhO4aB76HxACkNJBgb4aGLvD9tvVeTpJQslxG0lDzBle4+HBbrlQud9WY4qnRWV4HKdbWppNY=
Received: from BN6PR16CA0031.namprd16.prod.outlook.com (2603:10b6:405:14::17)
 by BN6PR1201MB2482.namprd12.prod.outlook.com (2603:10b6:404:ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Wed, 25 Mar
 2020 14:29:52 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::35) by BN6PR16CA0031.outlook.office365.com
 (2603:10b6:405:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 14:29:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 14:29:51 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 09:29:50 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 09:29:49 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Add new ring callback to insert memory sync
Date: Wed, 25 Mar 2020 10:29:37 -0400
Message-ID: <1585146580-27143-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(428003)(46966005)(36756003)(316002)(54906003)(5660300002)(8936002)(81166006)(81156014)(82740400003)(2906002)(70586007)(6916009)(8676002)(86362001)(7696005)(70206006)(47076004)(44832011)(478600001)(2616005)(6666004)(336012)(4326008)(186003)(26005)(426003)(356004)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB2482; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cbe7b12-326a-41fe-ee44-08d7d0c8fb0b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2482:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24822A6CAEA8EC61ED35CAD6EACE0@BN6PR1201MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9K0N9juNzokFdNJwx6hkGX4JVochdqJSBnPOlrYS7yHuIB2leW141jmYM9/KSCTtVZWohgoCidI3bilXBz7JXiykI7S/1ZehiEnXw5zlPiMFOS7akGHA2vOgRErnoOQ2+OmysKQXCVUHSBh+zeRM0kJWauuSeFrSiQTws/Dykpv1fvGcOhO4usOKQyFQEVhs1+NNVeKWtJOQCJZsAFTsw2GO0NF9HY7pQu2K4F/33RpT+3X5iBZZjzz9X0nVjMJMJk/Ax+kFhe0jsA4tqe0TRcAS5Nt4ixDbeIE0ymO1u5DYTjLPqr+IeTIZJwhrEkARJDIi/NOqj8wjwMZYFmhYwSFKFU9sC8wkztAp2Oek3gJ25gyi/8TYisuOTc3w8loDCCz+FoIzS4caVcQ4j7feUsOLY2ah64meYUx1oAR3J1soB/dh/GGBZu4CNLmrV9oUcufuik/DZ9gDxbeWbGfeH2S6VR2jrE/ikqFRxJWXZ5ri+QLWcoQYttBfRLXLZGNbrjbjVDJTY+o04s0Hrdjzqg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 14:29:51.9684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbe7b12-326a-41fe-ee44-08d7d0c8fb0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2482
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
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to flush and invalidate various caches.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 448c76c..ef9c444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -171,6 +171,7 @@ struct amdgpu_ring_funcs {
 	/* Try to soft recover the ring to make the fence signal */
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
+	void (*mem_sync)(struct amdgpu_ring *ring);
 };
 
 struct amdgpu_ring {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
