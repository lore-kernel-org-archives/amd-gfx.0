Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A0C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BBC2072A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eMnKdLLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BBC2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558CE6E581;
	Tue,  7 Apr 2020 07:52:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A4C6E581
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 07:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct+f0YCI6XFyVdCA/bjdr8P6qPyxzXX0gXZkeUEmlYYxK1wcxnJkeLIhAH5hcJazhRnanRXA2r5qkEClbVXcQddpRlZz6XXqDSdnE1IqDQuY9pqeiJ1MDsjBGYWMIKe7jIChsZ+A8LrRwqX85ItHfa3PFwAaAw4a13zlMx4YGwOFZRS10qWPJRlW5/auw5tATP3bjhn8hf1yAc6WETRxcS/w9jytZESurMmfvYhIE74BvdGERTOiC9KS51jaG8MrrrJs3mG0aabMrFR/o6+2aNbpXvIrgX/pxKqmhJcAlGL93+AfFGkxg/HCuid7+vnDguDfOtq88GDC0ilo410TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0OlZ+vyQSLRqpoR/nvBPVyumPxFIbTZ+WYOoR0z73A=;
 b=RTl5fz0cvsPE6GRQ0ZGPo/ngkigK43lWR1MgfiRqrqjI0z36En6XSnyb8Am3QJMr4ibtqZZcmxwBw5QzBuf7OobBVzGhVwHfV6PPDdK3Xg4Nb/qsVwrLgWMLKblCTQ7G5ZfXy9HHo/EHvMXQJ4/Xztf64L2oReU8hpBwaZMibKkUJdp9lcznaiadrf3hgjaPKhWtsf77aoZg/jiKCkiRC0tn2tKrxga0nOwFm5qjgTtymfr8E7fsdyXW+aNC/WVhfHvLisTF7H9R+kRvCTvLjl7t5Z+9Gfvd5gaIkhgWU3z+bDFmiiwZXpD7aaWZ9xXYWDLwm6kkuLZCQPufzxpc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0OlZ+vyQSLRqpoR/nvBPVyumPxFIbTZ+WYOoR0z73A=;
 b=eMnKdLLyFYVyB2r87FUEJIBzohxf1utAU+PynoXy1Y/mguVpAnD07TzwaxX8Ah3w3AS6QRe4Wk3FtFftE/zMOx0LmYffmHAuqwNuvgZWfmn5tf0aqJO+hG+wTXknjUuRWc80OGVrgCWao++9T9rvPNFAyee47ZH3qtsmrzdhBlU=
Received: from MWHPR22CA0041.namprd22.prod.outlook.com (2603:10b6:300:69::27)
 by MN2PR12MB2958.namprd12.prod.outlook.com (2603:10b6:208:aa::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 07:52:48 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::51) by MWHPR22CA0041.outlook.office365.com
 (2603:10b6:300:69::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 7 Apr 2020 07:52:48 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 07:52:47 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 02:52:46 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 02:52:45 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd Avoid destroy hqd when GPU is on reset
Date: Tue, 7 Apr 2020 15:52:38 +0800
Message-ID: <1586245958-31184-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(428003)(46966005)(8676002)(81156014)(81166006)(5660300002)(356004)(6666004)(7696005)(70206006)(478600001)(8936002)(70586007)(2906002)(4744005)(36756003)(2616005)(4326008)(86362001)(26005)(186003)(47076004)(6916009)(316002)(336012)(426003)(82740400003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917d7b25-d887-4a24-1826-08d7dac8a9fb
X-MS-TrafficTypeDiagnostic: MN2PR12MB2958:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29582B11165E5CDD81406A9ABBC30@MN2PR12MB2958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3ZwU9c4npIweeL6KbdulnM+FHHLvH5e8VU01KfQD1oWQ+L1OX5pSV8rPvjnm3uAqTNPpJqOqxhkvrnZ9H955ASkGMDLIXgq/NY7B+0sQDvyu9NfjqQymVnpMk8u+g4XTnpcpv0IxDnrKDKc0jSHovl1CBZ9nZWQuS5PINabkUspZOufjRWc9v+ofrf6L6L4HgRAumidTU4Vr/WuhaWlqehBYTFGAFXihb0yNNS6SYxR60NEpb4idRM0f9O2qEeJFyu+V/hkRcrRYVM6Pao+jghe026geboQ3lHrREqG7gIN4I8p/ezMMOZNLUFRDe0PLZmb/PNWx/b5abxfqRrt6umxlj5o+xCbvdQE4obUk+7Zus89hWSAzfChznx0kAgKC/iKQJK/6KmLk8Xz1rGib1xPJIJUvXdfNiPJr12qxX+sdmD0iXJhjQCyQfsti0w4KXK2PNc4uM9ndvhHnsG5y3U3BWj1VOXoOgiw57i3zWN9AEMQHYPOavixYgkWRRWwoAKotyV6d6IsQhHDQod9Uw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:52:47.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917d7b25-d887-4a24-1826-08d7dac8a9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2958
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

porting to gfx10 from
commit 1b0bfcff463f390c4032ebe36a4d5fb777c00a4c

Originally, MEC is touched
without GPU initialized first.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 4ec6d0c..691c897 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,6 +543,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
+	if (adev->in_gpu_reset)
+		return -EIO;
+
 #if 0
 	unsigned long flags;
 	int retry;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
