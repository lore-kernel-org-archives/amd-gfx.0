Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8504C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9CB20714
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R48HSfy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9CB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832966EAB0;
	Fri, 20 Mar 2020 00:23:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5E16EAB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 00:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvWgW6Li20gLzGHoli2J2MWquD5P/eyP3bMCTUOp+s3M4yQ76+DDhaWmDIpHDuzauXokAnKvcQACECc5CXaN/b/C3axn5yJJM2lVPPG9mFCxYtCs7AevlZkwmF9fV5A34ELiA7Dyuo1AKBwCQhoS9DsLuLDyaxHsnGnhCoVSjlpNK1Bes0cSbyY3RmpZtpBQN4jOVrKrit6NhPQP1FunspqZETT9J7mHXcE/HWWVWgya2yem7RMk/8aiUOXXV9mXFT8DkXe294RglDuMpT+ePDmtlpvoVGj0qt8n+I0wYfEKHqWGP32DGSdhgkMdEOYKy4cwWPq5ophhKLy0r6jFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnddvMITe1sgtvsh30vcOq5uyblyCOKInPHRAFUfbRM=;
 b=iCVaj4UE0nqy4Z1XjXU61XZBi3BFKUdj19IMMhCzcJOU7wMhM3Ub1KxLE/awXWrROf6O7WrZ3YCfKZ2cvWBnTUS76bGl7CKFO0YG3CACkaLpcfSJfdTuUUrY4i2pydDvc31yTR9eFj0Jr+arlgIOAwlhR7ykym5kkjG8AQiDnDmRNPdPTJ2qMfcONgoM9nsYPdsLbAIxCiFUXy0SnXw8na0IH/PX64eQjcc4+bix7WqwxyNFEqbYT4LsYMLsKnAK+BuEBZ8F9BsagnzAPagqr7e+NBY+jeGdb7GVMkP+x0uM/JQgLmVAlDPOEC8iNBhF6TgBVuOWmXdAZ8976HnoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnddvMITe1sgtvsh30vcOq5uyblyCOKInPHRAFUfbRM=;
 b=R48HSfy3cX0y373tFgFy1C1wFWxIpFe7/hhzNy4aL7EhvNb5Suajm0a7T+/AWnY28T//q8DTxdHHfqvYRymaN0HNZpiGH3ixPtrY7xUUmAgpgezoxiLD+EptwkNAsa4122ACxuqeOS9aahVUd1pIGCLH6m7w3t28Y5tgbZpnHCY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 00:23:37 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 00:23:37 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add macro to get proper ih ring register
 offset
Date: Thu, 19 Mar 2020 19:22:43 -0500
Message-Id: <20200320002245.14932-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320002245.14932-1-alex.sierra@amd.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM3PR12CA0130.namprd12.prod.outlook.com
 (2603:10b6:0:51::26) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM3PR12CA0130.namprd12.prod.outlook.com (2603:10b6:0:51::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Fri, 20 Mar 2020 00:23:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18bf6605-214e-4054-3a41-08d7cc64ee91
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:|SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB436588A5FF17B99CC4D80273FDF50@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(6916009)(4744005)(66556008)(86362001)(36756003)(6666004)(81156014)(7696005)(66476007)(6486002)(1076003)(478600001)(52116002)(44832011)(5660300002)(66946007)(8676002)(4326008)(956004)(8936002)(186003)(16526019)(2616005)(81166006)(316002)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4365;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpfPeWK4gE8/ZyecEEDbRn4u7ivrQDbsY5qHO6wRZ+vrijGVaovYIwBK4aelOw3HFdsVNmnrxxmGOcy4l0nhMAB9ajI4P1LdKxGgcgLWiEozUrl8p8Gey3zbJB0kGSrG1/Pa9IcX7b5e3rDLBHMGzTXKVgNxhh9jIXQFmh11R8MTQN01QbUbxAGB95c0jgOSzvUirMAVsZQaaWolg6NsP8jYaQYTYRn8VVVJ9h/IOa/8+yySoRMGd0UE3G1n+xjeBr+tswczFTHzzKAOAp+NRFLkSy0sDVMT4bat79xIilSxIavbm97KRsEMglok8IEULppv0O/ZbeYGX/e0U49+TVjNkQKINKTL5bAqVFoJntXNWdJwYff8W49LxRunGfvH/90zIZU0sq1jZqAyJ2DSLJel9PpTHQ3ixEJOnCMKJCgmPfe5U5BNsOah64BpCl15
X-MS-Exchange-AntiSpam-MessageData: nLUkQzpn3RSXyPAbV5lWrK07edZjTKrOK4PYEDZfSDtrwwCxTBtVFAmPeHaLn1tPGMHJzETwBXqUrtr7V0DO1SnaFJk/00oump7GELNXgyyZTET1CtxUT/yr7sEToSYKTaPml5r4qwjaHOgtm5P+MQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bf6605-214e-4054-3a41-08d7cc64ee91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 00:23:36.9984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwBc6hKVgD+rykhgIVbdFLyQFgzf3Y36g1mBp5HTSKZc0KqiAdPoSRYtIZVrdk5xra6lj1JrNxKJsiFqORzs9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This macro calculates the IH ring register offset based on
the three ring numbers and asic type.
The parameters needed are the register's name without the prefix mmIH
and the ring number taken from RING0, RING1 or RING2 macros.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 407c6093c2ec..5bd9bc37fadf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -34,6 +34,11 @@
 #include "vega10_ih.h"
 
 #define MAX_REARM_RETRY 10
+#define RING0 0
+#define RING1 (RING0 + 4)
+#define RING2 (RING1 + 4)
+
+#define mmIH_RING_REG(reg, ring) (SOC15_REG_OFFSET(OSSSYS, 0, mmIH_##reg) + (ring) * adev->irq.ring_stride)
 
 static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
