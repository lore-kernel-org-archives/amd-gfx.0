Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D48CC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 14:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CED206C3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qu4s6niY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CED206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898166E156;
	Thu, 12 Dec 2019 14:52:17 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBCB6E156
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 14:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE2ssopb1Gc3D/abavc+Tp+qFmN+B7j6rgxx7bdgpROehlXm2Bhh10FH5JIKIyyjmMhjYMXyjGR79AP1n+kLO6sN8QYq4yoZxBV489eQwOQQBw73DoPkADdBu75a306DHAj+8z7jc0H9BUo5PKkNgl4FF07ua9DPm37s7Dh71FDo2Na/GkXVEqxE5q9iP4NHchy3Ta+wi59g74qUf6WKfZt8+LDZPKFZKTeFdPYE0tLaIwI5TzOrRFwHXANFEGUmgsN2wJzNwGNoqL9u8hQaQSVmqpnKAnpdUFCqs1SSa8cPWVM6bpmd+1zuN3Gm60lrL4kbXlC/a59s1k2NkCip3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/qoyRdB8IRiM9Mx5jRZf76seuZVEOviYa6uvNx2sx0=;
 b=Wau0Z2SOD8MDD387iVTmDcSGsi1bMuS7yASnd6TrMZue31ZqGovfPGQ4zrYhzyQadSxEKn51xxIf9deWl7Z/KM27O+0bW3oX6V0Zwgot/tyERnznBg4jbHfj6GfIWCa1oyQl/Rt4jXuJQWFaSFk8QykHAaPPHFlsCeo69Gs6EXDghxgso92CslFj0JTwbhyjhWVIkU/h6nYynbJM+sgmHNCdqo92PfZkdbPkeQKrRbcF8yHFINFdi/vw8S8dF/UxuCjthvixCied+cLDaPk1goFg2143tEdBsqaPR8VMgCtgMa84kdnoOs6DfJ+Q93DJiwGGSIZSGepKJJtfCDZJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/qoyRdB8IRiM9Mx5jRZf76seuZVEOviYa6uvNx2sx0=;
 b=qu4s6niYR6G6ax2W6VBUh4fM63IK3jqGeYG9o89Av8bcaCc6PuNcq8njLNUbwd0yXv0Zcv+yNjGsX2y7JL0taixu7LqG4m5GII6F/ecdt0W9SOAsDk6G0FvgB3X+qbpxhwLn52o/QV4347hdrUCaNhWpmNmACOMbm00/prHYyS0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3821.namprd12.prod.outlook.com (10.255.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 14:52:14 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 14:52:14 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: queue kfd interrupt work to different CPU
Date: Thu, 12 Dec 2019 09:51:42 -0500
Message-Id: <20191212145142.14831-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b840c924-7d41-4e0a-423a-08d77f12e046
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:|MN2PR12MB3821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3821367B1281F1E656D48A16E6550@MN2PR12MB3821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(478600001)(6486002)(4744005)(6512007)(1076003)(36756003)(8936002)(81166006)(8676002)(81156014)(66476007)(66556008)(2906002)(316002)(6916009)(26005)(86362001)(4326008)(6666004)(6506007)(52116002)(5660300002)(186003)(2616005)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3821;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgEwiz6w9eXBEvUztneMftVBLS+S9WoqCacOkcTJsZGb2HEuX8VGU/EOd6bQWYz1DPOeOIVvTG/hL5yBRD7NgTNx3S7GtJF4BiFMrdmLIUcSEpANUMAb5Aa7k8D8pChfaZ6A/D/5HaYMwfcI/xFWrlggIYgzRcmdtJc1JtCfuU57/sECAzjsdJLMLiXrL0b0rgsHVf3x6G5eHgstXE8hiJN63i+R/Qfjcy9w39xGae2pS8j71rHyt8bBGgfl2cFxNglLx6Xtl1QLi1lcM1a14fquF8XhYgsdQzC+Lhj7EN+FF7TNzoiMdTm30Y6gmDq1oXQFizBTfK72YuDD4F1VMvNwrOfv/qVVgsNBf+4a8dQ0SlJKkvRNDONFKQbVg1ESntOrxX5smQjxciLd4t1bNMlJ7GV6k//RiX0UfSyuYUSnurBAoHQCxNQCrmSU9zu6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b840c924-7d41-4e0a-423a-08d77f12e046
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 14:52:14.8452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GHFnbVk6FAPCXeY3Y/1inApE2VzYUuNqlWzfjrRXdfFuhIadE4BUbqRLP5GtGJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because queue_work schedule the work on the same CPU the interrupt
handler is running, if there are many interrupts pending, it takes
longer time for work queue to start, or even worse system will hang.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 209bfc849352..ee2a9bb1cb07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -844,7 +844,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 				   patched_ihre, &is_patched)
 	    && enqueue_ih_ring_entry(kfd,
 				     is_patched ? patched_ihre : ih_ring_entry))
-		queue_work(kfd->ih_wq, &kfd->interrupt_work);
+		queue_work_on((smp_processor_id() + 1) % num_online_cpus(),
+			       kfd->ih_wq, &kfd->interrupt_work);
 
 	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
