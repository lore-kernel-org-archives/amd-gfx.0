Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD68C4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 10:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6043920752
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="icp7eQMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6043920752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264556E2B4;
	Thu, 19 Mar 2020 10:52:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4387D6E2B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 10:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHAoAwrl1j5QyE7cXOOAe/CvwIQKygjucCpdOuqDj2H8SMpz1x6KIP6Wx+vJtXpziXNIdm0P4JIfxS+7BCEvzKM+aeVteRwmYVIbZguSVHOTz9OTSro6Ek2CgL5eN4466++htBt8Yqzxd6H+xGebOjw9BawUzUtCGI260zvgR/URtPt8MimhR2kkBc1DRSKTivznSagf+WYO2zimw3+xG/OKnZH1zmFl7NUlpgK9eyJbCP8MANrb2Pr7wDJTDHWpNYFKCjxPMo+6fEJlTXOpw4c5DGSN9oPa5h0JH0/8U7bBE2yf3VSAr+lPsTR7EGttPg6UE3c6fx8ZBTnQMSduLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dAQE0qwTfWBp8AnJUqD4hw0ZT4TxgU5MoJssxax90E=;
 b=ZlkZOZkcgN2b9bT34Pb0xdZLN6vi2NcbWlZl+nLrghL7vDBjUsKopZ/eve9gVzicbxP3ZZMoVSFlxhc6kKvt6pzymGnwDx4qTg82Y60LYlc1CMWevVyAsCtdf6ai355pDbyJyGfO//phsII9hTodorjGk7qQvIYRlSm1ZhTVwcowo3+3bIMTDFD37yhzJz8tbuF85/fW5mij2JTFjlx/OCT4yVuzb7mH8NiyETG32nNqSxDdu52GxnvghQcYg6Mxw8kgbbV3Z07DgDXWjQ9F8eoDl5yY4SVaMTNIEoDMPhYEvrIJhBuilM411bPUJeuUcK8dJlsXGZUeXg9TizbbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dAQE0qwTfWBp8AnJUqD4hw0ZT4TxgU5MoJssxax90E=;
 b=icp7eQMnNzZx9P6x1G29TtlSqpnPlbpEsi4jlF+SioqmKweb2/Obs8h9RRWKjDX/zKgh77+ciWEyJJEVINbv6kjW6Lz+0eNJiFjeqnZKcZIFokLRPIrFe/kScyiSzIICPKT5QxhN73uHfMvhrQ7kCMS+TfqkGK07XZLy/I7wSBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 19 Mar
 2020 10:51:55 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 10:51:54 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix the wrong no space return while acquires
 packet buffer
Date: Thu, 19 Mar 2020 18:51:39 +0800
Message-Id: <1584615099-8115-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR02CA0181.apcprd02.prod.outlook.com (2603:1096:201:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2835.15 via Frontend Transport; Thu, 19 Mar 2020 10:51:53 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf5382ac-ef1d-418f-dd1e-08d7cbf389b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3327:|MN2PR12MB3327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB332716AA62982CBC4E5A4DD7ECF40@MN2PR12MB3327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(2616005)(81166006)(4744005)(8676002)(54906003)(6666004)(81156014)(956004)(4326008)(6916009)(2906002)(316002)(7696005)(36756003)(16526019)(86362001)(186003)(66556008)(66476007)(478600001)(66946007)(26005)(5660300002)(8936002)(52116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3327;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q35GuoSvDioKlNjeRXd82e7XYj8HckcO2/1qSOqIYSC7GUs8YWRrkjPB4LRxu83ToSjJ/akn/lVKQrmqJ0R1hKgGDAd647/5388nhj111CjoTEjYmV6nPDiw9uLVFgJmTFhyz7WpmZLTGQOF6El1W1v1fhn/ntlK2KxKYzpveDOFeuV4lZDQ65D5Ld/3GY5PktFNSyrXjWOumjEJv33kUX35128kfyFdQs9VK1qRtZDGtDTNR0U3UcEwGHw2q14rPa9EZTwR+h8FCZjmun2ZFJ5PrGdA+c8+Vxu6ssEHT/SIpQN/KwsZuN/gkmsER8wYa2ZqPwtBFGe/fyI8dEpV7pDawH7NKezy7BkMXaOy4TmUXfTPugfukW+UlL+LR449HcnYnDC9uYX2q8BkZUqvt8VKyge484+g/5LjQlc81HLcn+qT5v/7vrS+La7gR8vN
X-MS-Exchange-AntiSpam-MessageData: 4S4HWOJ0+PLGbrzcU4qw1pt4cd8yV0wBK87FWnKYYrFKe69MXZzFq1XD4MfPoo/8xEPGS2eUB2rb/V8QeXqv3GLEc2LT7RDNW+HW/c9MPPovtQkr+OjzmtqElz274bu8cXj6rTRopvf90WrXovsCZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5382ac-ef1d-418f-dd1e-08d7cbf389b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 10:51:54.8176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzSryH5vn60c+sTQ+Hxt4vwuUE9mRt0ReXHTvd6VOkbpX7nuhxiIVNGYjkPHHUofRP8qj1/tO1RTBHm88mxlyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The queue buffer index starts from position 0, so the available buffer size
which starts from position 0 to rptr should be "rptr" index value. While the
packet_size_in_dwords == rptr, the available buffer is just good enough.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index bae7064..4667c8f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -263,7 +263,7 @@ int kq_acquire_packet_buffer(struct kernel_queue *kq,
 		/* make sure after rolling back to position 0, there is
 		 * still enough space.
 		 */
-		if (packet_size_in_dwords >= rptr)
+		if (packet_size_in_dwords > rptr)
 			goto err_no_space;
 
 		/* fill nops, roll back and start at position 0 */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
