Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1E1C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFA461159
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFA461159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D9C6E10D;
	Mon,  3 May 2021 17:26:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6503E6E10D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 17:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJZ3VyKgLasItj5ibBT62jR3NufuDnB7ueWD1IjQmtmSZyTjBI+HEzALBYKhKPIAOhXOlSolP44QVC5wfB0GynRSUCZtkkeQ43lrN3C7BYilXvgUmFxw5nO8MtMtO2ZeMi2dYannI29PhKA6BgP7ExRbnFkaTuFZPVcl7OCCysyzo1JE1T6HgZQFHLbRIphkKw3WLhgyjt+idiaT5GFrME7kRXRztSdMB8l2jHlO6e66dBu+bPnn5ZSFeSd6GevDiijh/VU0r00MCLC2qFCpD8gnTXfXJ+aFBXgN6NrDNIn/JMPEuH+lN7fx6qDDgBZE6LcFJf4fLXey4BGo7AyCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMOdK1px+xzhLAHF78xIIIE9SNcNCv4zxzcE0W3ujQs=;
 b=frIdBUVHKXZ63P/FZRxJiyVoYgMC15ZWSj4LTJTeR3FDc654FkRqZ0WLQEtMsPmKHV4I8Rvo+vXhUpS7QukdfYrMmiLN4CGeBSnH1utwDoY5kiYjbGMK0xxF5rka140Gl/nCpmyi/mVpcyGdWKbxl4Cbf8ObYzF3tJuru1oqpxxBMtldabbrc5l+TtxFYdsg9b67GHHGTxJ7eEBJH/j8CxLFYC2L6YTymjYhYvWaeeKGwwgIAchBd932PrlpDpXdWD5bCBwspze1cGCAnTX7UFFTki1cgV4yn8Z207/bW70JGi1Nxw5MXwfMudMWI0Qdg0rWjv6tcmcczK3Mn2Y2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMOdK1px+xzhLAHF78xIIIE9SNcNCv4zxzcE0W3ujQs=;
 b=kPwcVBPabkDad86z+EbChBy3aPenMVwGTOa2Vme7HRZl1eQLMaagDHkZt8Z90dXu3VkrEnx9AF7858obcn5yA0i9Tr5jNX05kHLjtMS2fo4bYlfXpqtZHfgjIoWZEPvTh/ySC2q5LLKZqzOZBtKTttv/QeaFcw/5uovHado7t0o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Mon, 3 May
 2021 17:26:07 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::f9a9:4adc:42d0:fda1]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::f9a9:4adc:42d0:fda1%7]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 17:26:07 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Update NV SIMD-per-CU to 2
Date: Mon,  3 May 2021 12:25:57 -0500
Message-Id: <20210503172557.1130985-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) To SN1PR12MB2382.namprd12.prod.outlook.com
 (2603:10b6:802:2e::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN6PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:805:106::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.2 via Frontend
 Transport; Mon, 3 May 2021 17:26:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f60a8e-ccc0-45ad-d1e4-08d90e58896e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2557DE27FFDF2A576C51F489F95B9@SN1PR12MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJhu2x2/lAl2TJGjVMMfM7pRId0kycLMvvy2bP98WpiuU6dn3+YOGJnTWCNTYJ9h6dT2vIbcEEKUbLx0mMborqTipk7P5hu6Zn2lPvAjnWN5r+GP70YQgoj3nkV/MYL593jeUkxUrssgscKmmYCA0L41Yu/cHvtHh8/iQGxu43f5LtLWZUac/t6CBPxXAjl+dbp/mN8NbOqhKO8iTddOv9og/dZuDak37hUxCbsqKuyY220JSGrDQqOF5M02hTpbKjgLs9BguVSRamX8BSTLgpG3yDCrh6D0fQmxc+5rf5EMKxIeWU3QRzB1D2FTIHnt1jXath2qRG1/qMq+Z6N8iCncWQavfZ9PwezBPUOyD1TKBlCRhtOP1ufzMoqTMvTly5m+w0PUBAZtj+01S483nNIjHXF9OLktF8Itq6oSmu3MSNQ3qSbrcMvf74JEpQTw6KUjqzCA/DvjqPpURdGlgftrS06vUx/IRAEfM1YXENjNhXnYnYsfhS9Huy1wJs8Q9g81xQvBmNwekcSwPdH2SXbhn1yPKSF8Pip/h18uYp3GwgTtgk2TI6hoQkaD5XxNNRfUezf44Hf2fBh+GVdl9Q2m/0QY7XMKFyo+rEm4PoLPFFBik+Faj20uWu3iO6QJstNyizj60sjwINTZXAMuycR0szMA7OFc8noD6NOpUVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(186003)(478600001)(8676002)(956004)(2616005)(83380400001)(4744005)(4326008)(2906002)(86362001)(26005)(6916009)(6486002)(38100700002)(6666004)(66556008)(66476007)(7696005)(316002)(36756003)(52116002)(66946007)(16526019)(5660300002)(8936002)(1076003)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Lg8M6zsIti2AbtWnnwBfetBDadZ9cqzaYtL0VDSOvKUojldJMsz4idmc03XS?=
 =?us-ascii?Q?CIkhe6ykfzK8ixjPpnco3fkAVg29DUsPSpLYgRKbUUjXUbqbbiAx/5IItLus?=
 =?us-ascii?Q?UnBhzxmcrkFFT3u7oBvdNT8hIGRqTaesbPRpbAUd/q/3teDw7jT0451zvFsH?=
 =?us-ascii?Q?y9RGN/hteJi3oBGN5Bxv39bf74VGPfbwKZLJCDFOyDxLbKh/dkzRbmuPxqjr?=
 =?us-ascii?Q?Jkzxfuu85ZAW8SjTHV2JZF9WA62daGWjACQyQAudJ6wGTIUXkIx6FgbxrtoQ?=
 =?us-ascii?Q?4xD3iLKqVDdHs8XmqTLTJwkimoRCEwPh5O6wTEGMnCgyzxXIVQIMAFXuJJex?=
 =?us-ascii?Q?B0f8HWXnpVWycSfyjoIT0eDpkT8toHY+kNZpn8igCZsNpF+FSl+rVvIiu2az?=
 =?us-ascii?Q?1z8LwVEcNvJXoK80DOBxaCylNTxFJxVAzEW5zylUqyEHky+fkFBzqW1gcZ2v?=
 =?us-ascii?Q?CCtkQ5tQ2AkwDziGFLJPjZqLUM6RsGCcik4/lRhAZd0MC/CRVqTpNRHJvLAV?=
 =?us-ascii?Q?qtxWmXNah+gFJ5j/G8rvPF7i20T5PM6mtsUfnQmwSTIY0Bs5syc/352VjGiY?=
 =?us-ascii?Q?ShTvw04bMp3mir4UkJPR9L2mEHamTB/6Evc1qlZQO+WOndrPCVAwqVSoQWy6?=
 =?us-ascii?Q?bfZroo55cWdgaH+LB28MGSKvXlyDU4bgHCM2ehWGR3V8rJvrNRXJlppONw8E?=
 =?us-ascii?Q?rL5uDgapLp7XxlC51MSFAeD0pEkfhQAlPFPlqyyC3Q8V4OYnqAutWA0CFSfx?=
 =?us-ascii?Q?PWSfnq8OHYQOKmf8YPQR0Sr+VY6mVjZ79W60sNZyM9ZDyM94OuzEHJQaqjzL?=
 =?us-ascii?Q?R9nnJ1sN7O7FfM6WKOfV6ADA/3ycP1THcwmmZY2o38P1Vi+NhLA0JyIWaUnr?=
 =?us-ascii?Q?XQHbFIaLOzjW6omRppjKpqOkfVcexV4ShQ/wGbPvkWLNUV5Dw7bWQyOaCNgH?=
 =?us-ascii?Q?zWW/yZkUYppEV1aIt3n5gcm0u7Q0aSuL8OHh1nt9xperSNrlq5+z6J6E/ePy?=
 =?us-ascii?Q?DgLe5H0rafIUMnmNPIx1zIbBBApBKsFaCdouei6luMXTB/QIE0H1XMrOwu5f?=
 =?us-ascii?Q?EARL0+x6xJM5MCmkecizL7k9Y8Cu1g828QCAUW4seHLeD/mjsf39lFgrCHif?=
 =?us-ascii?Q?hyZT5cHVM2B52s7hrj0R9dxqoB/DJylH+0cP0GFb3XDMMRsf9w1h2kzzLQPw?=
 =?us-ascii?Q?n63tLZGxgza6GkDRm951OJ8RNLXkvKxwkNqplqsbuk7l/vy9pCsBxw6s11yG?=
 =?us-ascii?Q?3l+yKjJqCVRC4lqc4sWMFfHi8UgLCJgz37GtrK700iAGQsGFXw7GbajivYAx?=
 =?us-ascii?Q?TjZMbBZxv6pUmIAIJPUz2N21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f60a8e-ccc0-45ad-d1e4-08d90e58896e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 17:26:07.6867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmJs+zA+hIOgMdwZ57+FgIuOcOBHGoJw5993Xg8ezE1MG4yP1ogJF4t7CKMWFiLekhpFZFt4gGKZj74Bk8M8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2557
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Navi series GPUs have 2 SIMDs per CU (and then 2 CUs per WGP).
The NV enum headers incorrectly listed this as 4, which later meant
we were incorrectly reporting the number of SIMDs in the HSA
topology. This could cause problems down the line for user-space
applications that want to launch a fixed amount of work to each
SIMD.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: I94021ca71363a3d27330b2fda8e6acaac258017e
---
 drivers/gpu/drm/amd/include/navi10_enum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/navi10_enum.h b/drivers/gpu/drm/amd/include/navi10_enum.h
index d5ead9680c6e..84bcb96f76ea 100644
--- a/drivers/gpu/drm/amd/include/navi10_enum.h
+++ b/drivers/gpu/drm/amd/include/navi10_enum.h
@@ -430,7 +430,7 @@ ARRAY_2D_DEPTH                           = 0x00000001,
  */
 
 typedef enum ENUM_NUM_SIMD_PER_CU {
-NUM_SIMD_PER_CU                          = 0x00000004,
+NUM_SIMD_PER_CU                          = 0x00000002,
 } ENUM_NUM_SIMD_PER_CU;
 
 /*
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
