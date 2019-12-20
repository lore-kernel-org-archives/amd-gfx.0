Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04320C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAB6227BF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nRw4gCYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAB6227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC6689C54;
	Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94D789C0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 08:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvGSxBay5ogcOi7hZwDnHUVViyVkry/YPY1x6VxHVIIp/BlZprCPEyfaU3/7ROkfRB1TLu7RLuP7a5uGURHhrKETZWHFpNBptP8+OhpVyrOH32ZGb0X7fcQmdxf/HakQsOpG4CyiGHi2BMQfdH/Zll3WjwJa2XWnM+WUVf8N45nZBvxCL/b4bWzcALVLk4uDmrT1B4Gc7t0sVS5viA064FqvaSiLzd3zOUyyjTK5aJU9ZZ3SOd/jwSkd3jh7Q+R+BblYQBxtBoH3zf9LNUKUwg6AlnU9b2WKh+7Mnp+gI8q8qTKWfVOcyVQxlJb4+wPCkZL+DrfMikPWKrP4geOoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J57l5Swe+k+RtLIAyDn0HjHmTZNAWvRc6o3P9ufZJWY=;
 b=aMPGRPPnhXH0UfeHYfCjvU7dcMb81uSuLIyrrSeVxpUByavNR1dwmYzasej63FaXMbFTLIvCRD3ITStWaPvqVNJOOOcWjiqu1VFAmRGSMmMTQRbjNBCg215/gWHG0VlRTrG+0rXW662CHQxZZoD+VzCbRKTwG6wOr89zP3HwfsAjNdyNIcebUJDbQqh3yDstBgA7s3VMnP55mW9cuYp/oBjQ9sftQpXNZwuIXxgh4S98N6szsdoKjqMPstCIDb/OLQ8UElZLHMC6Rg7nLaNz5RXQSAlz6M8e0SrdCkAJAzHfB16Ocqx7SzgDPwp1rcWhfkkUlyHFE9FvxpALcuo2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J57l5Swe+k+RtLIAyDn0HjHmTZNAWvRc6o3P9ufZJWY=;
 b=nRw4gCYWftb12u/r5O8SMsBfGfd1/oL6ZFBF067pvnzx/1KFonWnwlQvamJOk4FKxh7ODsl2zdGhLZUqg4yLTx7oV2dr0vfKo3pYGIL1tJxS/TwgnLPv0sRs8UgmWLKWgzeKmzWsbVNwFnYdw1yU2NDCohiBPxDvLcgsOvxn9ZE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3215.namprd12.prod.outlook.com (20.179.82.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 08:30:20 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 08:30:20 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdkfd: Fix permissions of hang_hws
Date: Fri, 20 Dec 2019 03:29:58 -0500
Message-Id: <20191220083001.30607-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 08:30:20 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b89f31d9-44f7-47ef-7091-08d78526d991
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3215E56708B3FA62482AD651922D0@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(4744005)(1076003)(52116002)(6666004)(5660300002)(36756003)(186003)(16526019)(2906002)(7696005)(6486002)(316002)(66556008)(66476007)(478600001)(6916009)(956004)(26005)(66946007)(2616005)(81156014)(8676002)(86362001)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3215;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TLVJOyX/7LsnOuJi1GEgOsBoESmuF4qEG0+IGzXMCWcVlma4FRPUnUpo7iJshwRLG9XuyY9k11b+e93VAyAljoKQxpc5LB+HQ6225LnHv/9J1kcIxF18ORU+8ghatR1m9WtMq6SCiDu7h0QKltmr7u/JKqMdVSQsfn1/mfxK4bW4zdeawcuN4XEoCqekaVQUOnx9lTU3gSXrYSB9JTP9oh/mQvFo2UflO1xLKFKRis64JmtAD6bICRlajaah1l0Q9Od99gMWrtn/ZJo5QZWK9LxyQ2FWm6Ej35YceOxZK/rWsWEfDVrhM7ik1Bl6P+0wPvb4HfkCJMrN4xoOaMaGcldOYQQvXSFJvHjudtbAnPy7mZcpHBm85oR9Cn+K1Cr72RtXGRSsexn4xUSx7O5KMbMEVY9ltwaF1RSK0ZU1G30B2YJWg1HGH0deOflJQiX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89f31d9-44f7-47ef-7091-08d78526d991
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 08:30:20.3912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h8krrk6VO5bAgjJbnIQ0v6OwtyVQrOpxgCXLUTYRV1g7NePtadOGn8ehjYvY95J4yV+K3XY66fXaYSaaq1+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading from /sys/kernel/debug/kfd/hang_hws would cause a kernel
oops because we didn't implement a read callback. Set the permission
to write-only to prevent that.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 15c523027285..511712c2e382 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -93,7 +93,7 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
-	debugfs_create_file("hang_hws", S_IFREG | 0644, debugfs_root,
+	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
 			    NULL, &kfd_debugfs_hang_hws_fops);
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
