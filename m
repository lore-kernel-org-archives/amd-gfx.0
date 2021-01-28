Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43959C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 17:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C4264DEB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 17:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C4264DEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527A789A9A;
	Thu, 28 Jan 2021 17:44:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3DC89A9A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 17:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBJfrIeBjo3K7Il7IuGA2Z/M35Q0f1H+5YKbeXJxAUrCuhv0H3/vyCBfWfPFxnFD5zhbL59lE3RAdYCNERJ+ud7oCTlJw7tB/ZkgBsp0bJabLGzMo0yduJXOPdvkg1T9Vg88/lzJYXRmXmgUWgymU4YsPKrKOixShulxxL1i1xTCmzzbamYBL6BAIgHiqAUbHoFjnN9kXrybU1vtlueWNFohDrZWyYU1VVuFCKLBcTIfKL0m+ujJoSfIoTuWPKU+iED/qctWAn4Ad4hX6F/DbdyQnjpL6he8cixfDHGcjxpEbjUIRYpeiN9C4Tg1BRUL8f0hiaE8AhhAFVciaL7UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oFCvBKaNGcHF6qa3+QbrI6xYDkTl5TOOw4qoTsPq1I=;
 b=XmijzYmsXjCTW5ufZ7zWMnOxiy2QeOs3NmjDLkOs96uQEVIbLX1j11q/BcgkMSqs3HLpkO0YHT8yWJp8/Jh6xRkG5NCTkrip+fJo+9pENjnJd5iNnRWNweaRQqfYHAGuvwedjg4w+rRnQSPTBweOD5eW8cNKLuNyojOwaBPEhb1ieGa8NlMbNiwNfpZ0jKYdzA0XMNcH29o+XzwnswOuXdHAyoV03vwO8j3mFVRePdGzanevkhvDU1Hq3aY/NKVm868pBoo5/Itk+U4MedHJn6cnQCqLbkvku9ItpRpnBshI3Wuj8KajyAJ3LxTprhvOyfrageI95+D68W53xMYp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oFCvBKaNGcHF6qa3+QbrI6xYDkTl5TOOw4qoTsPq1I=;
 b=qUeHkRpMqCMKdR+n0getRILQeZxPDoZGC1SEeVpXRBZ0hw6LHHg0LZvJhIcSmjWhWiQTADZYjUbuQ9/FBG4+/UVZGrsTeGPUitAHEuKb08H+dcPLDxPafaFDIAMnGngwko2VnXvS9Gr2fkoLVyMBYrzSkhI+Xq/CFXsXM/4t7XA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB4702.namprd12.prod.outlook.com (2603:10b6:805:e4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 17:44:09 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 17:44:09 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Limit the maximum size of contiguous VRAM that
 can be encapsulated by an instance of DRM memory node
Date: Thu, 28 Jan 2021 11:43:55 -0600
Message-Id: <20210128174355.7097-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SA0PR12CA0015.namprd12.prod.outlook.com (2603:10b6:806:6f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 17:44:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63a1a885-5540-4385-ad69-08d8c3b450a2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47028756768C40F69247AE2CE3BA9@SN6PR12MB4702.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI97djOsAc4v/bj60QpxCGZlSH3wTR9htZlYIeF0hQ7OhlSkV20zTHRVCu+M6E6BZ7g12IgfKOfIAe+Uag2fJVp5sAiqXwAjTGGz8nriR7c3wqr+a3nylW1YkhFX29mOW4TOasnkaLzCCxUKLhB5LNzxuHTcm4b51toz4ik+2HlST4FJNI/LYNTrvNfbM03wLC8mZI6XQ1184Li8E7ixYA0qmpSRVID8pqv0PvaHT42pQRTZqKrIEjQhQvm0SGPKE7H7NSZPh6vWw2rJP32FJp4ID/uUrAxaD9u8v5P+bhkNkZy8FFNd9FxVISu06j9Y27Kc45flHiO0UXOQQsGkoCCVmSH/eNpZSakCum97OIX0+/IBbSzlsrB7g6Ja6ugHnPLMikardKAM8vA+CnzTxQepnSz9/NRMvNnVCaY6bAGQh0SNA6ZcwUsYcX4EY4UxMlhBHDVRPSlZPPZhgnlklXumquO4NzW5YRXEqANgSNu1a+7woCIEAjVoz83YK8RYOu28GsHuig42PtRq9NQOpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(66946007)(7696005)(66476007)(6666004)(66556008)(2906002)(8936002)(4326008)(52116002)(6916009)(2616005)(956004)(4744005)(26005)(5660300002)(1076003)(16526019)(8676002)(86362001)(6486002)(186003)(36756003)(316002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W1BzhGQ6RHY4aRFRwpEbn1Em2FRJM9M189jitVDCAftYr8BDkxy0l3+p4NK7?=
 =?us-ascii?Q?v8dul7eg0Y7+/Arzj0PdmtTSukQT+AX5eOatRuMXykDAIYHd/IzHqs/KiREN?=
 =?us-ascii?Q?9FTRTDztos5o2hsqx1bk1u1XbLZjCplp6iZTg3yFYqppQd+lCjEIGUDfFuCp?=
 =?us-ascii?Q?6xOgrcog/KFgYwprJQ2X7oVI4CncRKhyTjc5MpCs+IqyRab8+XUXmQZ5UN7N?=
 =?us-ascii?Q?KDkohFcZSUbmyqV1o+F1nG+ecb7V5XjQ2HFf8Y5MvapowO1/LJH2DXPKL6S0?=
 =?us-ascii?Q?g27lJV87tsNZWqdIpEE1HSxGJsc11uQVcUiwzK5YBn//vLT/P5sAEwE3p0zp?=
 =?us-ascii?Q?XcgWpaoMfC5gbD/PtQPBSrlVi6bvQKgDddRMTM/vItJHZNd4ZXkiktcuQJaG?=
 =?us-ascii?Q?d+NY9MeeKoWMri7Wn0VwdbCvasG4GeeaitHxPZgcoujaI06HhWEUmhEJ9pRG?=
 =?us-ascii?Q?bDkCD3yzgDqLYUsmBeVxscxsn40V+P9py4m+qxaarwOZ1yAt8b0taoGQhfOB?=
 =?us-ascii?Q?JfiT42RuHu9TswCL8lGxiC8YuBMtjUHYZRY+l5AQoxKSOi1YSYsjiI4vHIN7?=
 =?us-ascii?Q?DJ0hNFTnbTlM4019wzfDv0Vi8ZjEF93dXJjm/1JA31wivr6zr/ZpOj3915aO?=
 =?us-ascii?Q?Jyk6yA6jI74NljENnpo1/mwIHwnZ8IAof17+r00s+6SypmWotMUEpw0CMpac?=
 =?us-ascii?Q?oMoF5wsX1QFd4iGG6wgtEOi+IkM8k+ee4CAt1mkY7cqAA4uDACpMwa5BPOKF?=
 =?us-ascii?Q?0nPIE2hc6TTPIGyGK/lWg2u+fpDSRgkPOx47pqJ6hJrxHanBTfVCBf63i4kA?=
 =?us-ascii?Q?ptwjSYehYuf6qbjepPihPoxEndwIwsHAjhBr/igg8kc4pVvzB9CgB/J71UQ0?=
 =?us-ascii?Q?VsiHw4nqaX3SYKOEbxyFN5knA1n/diIHpJ1ZAEgrrKGSd4nz3iPf6VGvBLII?=
 =?us-ascii?Q?1sRCPO7l6pQTQR2SLBUVnEhicUDSc1/PhFn7vXmsqhEZG708xhnslLCcIV34?=
 =?us-ascii?Q?laQ2r79txcjtKePEuDy+ejbU6HOlKnLi7GE3T3ZNJRc+oBnw/BrK98WOGS8H?=
 =?us-ascii?Q?AfPDEKes?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a1a885-5540-4385-ad69-08d8c3b450a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 17:44:09.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkKVI5VdZzJ6+WdJHNssOk7Xs//l+znOiBweMG80TBst6uIi6u2/scgtac8YXq4DqDTJGt8Bdt3YrOxb3poc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4702
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Enable 1:1 mapping between VRAM of a DRM node and a scatterlist node

[How]
Ensure construction of DRM node to not exceed specified limit

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 20747d8b1135..21d18efca277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -476,6 +476,9 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	for (i = 0; pages_left >= pages_per_node; ++i) {
 		unsigned long pages = rounddown_pow_of_two(pages_left);
 
+		/* Limit maximum size to 2GB due to SG table limitations */
+		pages = min(pages, (2UL << (30 - PAGE_SHIFT)));
+
 		r = drm_mm_insert_node_in_range(mm, &nodes[i], pages,
 						pages_per_node, 0,
 						place->fpfn, lpfn,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
