Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BFC83004
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD21620787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R7/rU0ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD21620787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D5B6E119;
	Thu, 30 Apr 2020 00:01:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F2C6E10C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 00:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAKdDUEhhVQaU18kYdKb3KaWCtx5K6/Bc67Pg6QDYRgAzYDdtCvZkEqDUf2oLOy2vjgpEFHrswl2BdiJCOwMOcjI4QtpO2ZtcVL4M0f5kx4RLcRySTNQNCFU5Y7B5Mbtsy6Vi2ZZemIFs2S+olXFGum4FwHgnLoa6JPaLnYth5lOvFqEG7M46YUfbX4tAXbZw4b8ZAnWerNR2S95wMpkUgmV9DNjRBVc+qkv6/zb/V+m0xCu8uvQ/cFpJkAOWcKpPe/IEGN/fFG1zarIqNyWT9fmJuZIbTIJ90mkkflX1cd36iMT+Tpx6Q2Pb1w20brLMB/OtwK/u6ltkZXsQXzkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cg4bZNb2ZnKejQXLAm6SyPDhdcmRRgHf7RbpxwYSQo=;
 b=c8oA3vQJLjKhmPoVLmTrg1ZO/9IiAESrPZ+LDED/ymXX7fJIF/ByeBLSsWh+7GfKnIx+ZCCTVvgv1tJMJ5PZMP70/R4ovtFalAAjjSl+UXU8mpFuy9upilwzzJuksHuL4qlO4KWj439Ubvekl7CXi6ly88U8az25cSi0TI/u1IP0x3FB4CbGxMS6tBMMAyYOHAQ/ABVJdBv4wGhGdaBHpIk1BWKEIa+WUQWzqYG0d4k9/opJdZlAN3UQOFIOFibkvwTHjhJ4XQHjkyl//MrOhK73VGWTt6OrWojcA7LJv4sugRKQk4K0HRfPQO52H4+6fkU9yHW3KgTvEmrt2OXRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cg4bZNb2ZnKejQXLAm6SyPDhdcmRRgHf7RbpxwYSQo=;
 b=R7/rU0lsNX4dB91mJ+fDx833CEkjk1eso/vUh0xIrNzOAMgmpJb/fgzNrd8jW5gCN1c5vKTs0rKS3uHAF0iOqiAgM6AatSnR0Fh1Au02My+dJBDJM9NoKC2jJwhhkHeP6r9JzCdgYRbL/WXy5lZHa28k/QB6EbYgM++/S4JBBMU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 00:01:20 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 00:01:20 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/4] KFD upstreaming
Date: Wed, 29 Apr 2020 20:00:43 -0400
Message-Id: <20200430000047.31083-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 00:01:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83f771c0-e483-4d7a-a536-08d7ec999cd7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575BF61EB9C16131843606292AA0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6512007)(186003)(6666004)(6486002)(16526019)(956004)(86362001)(2616005)(478600001)(66946007)(69590400007)(36756003)(8676002)(2906002)(6916009)(52116002)(316002)(26005)(5660300002)(1076003)(66556008)(4744005)(66476007)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvjLEY6kH3S4dqwWoxPPsmDHNlN0IdqXGMfTu1B0DtmMegaG0HpHyUuaQzTsCgRJsZZhQ4pl2gARUZyTxusJ/wKb0QOJBWhFQOnaYYnmjxS+vW8VDh2dV1ShPbA0DdUXCjk3WdH/XQzR1Is0r2/NKssNsWNbFwD11/qt1rh8NIwc4dNjiuLWZ+6TW2CJ4PYRUZTiaiHzIrOgNZrYScLjcquS1bzHKJEgANfimxtsu8TM4hspP5QO0khFzd8cpCszOv6xZmKCqqP8chCu3ul53Q0OICxjri+BtdASsFjvIU2U4Y8D/J/JFOgw+EzueVz9wVBaK/vwkVrQ8RKMNzeO+hr5u4HfJOasgSD0eYt3AK0PaqCYXqwOPb+M8tgpQxuyYes1wEn9hvW94hwVZoagCHCGd0wbbP2gunLP2+q47pNCJqSC4ajFx1JkHfWzP6+rVt+oLwaETCLilpknS1a20j6bfYYztW/7avNVLkGqNIslIHUwqs9qTdi9Ijx5zeFT
X-MS-Exchange-AntiSpam-MessageData: o/RUDiiaAyw/BakD+bw0Egod7ImCvSpETevr25xLCIU6LK7SqdY+qZ03bBvjVXCr65OOkRCKJT170W0koeTABHIrinKwscK+bmnaz/UJNrFg3rv23U3GR9SIV7XA+9RYGD06X6Hv6fvy0EIREKjPaE4MxhhfbDME43juX0vqEHLeV/4sda4J+0r1DDg8f6VgrHjyF/SGjyW+3vaZD6QsbER4f24uLdWonZkLqCWZrslQigj4/TTXspk2LQiZhyK0WMEt80PR7/IfFkRMSOSemSWq55DFOqz1l6dGm4etkuLdthsdnJlezI2M5UHUorTiBuIgK5NBAy8n8no3vEw/gana0j7E10it8wIIpZUrTc4OuH1v4Im1feOpGHrZEkf2NzG77oDGGl20xatU8PB8B7vSgItSH3IXbwepYmkWcNaAWiDfp0Izkum/K5zsDS0FBaNgD8PFN+1gFTiCPqKrtGMKVxBPbFGvExh5+5FQg0thmquroWX9ZtVLJVUgHElPVgx1dZ2AbquWcn+EdbQE548F2vYrhupbiUnQHfVwHFfi6hpQ/3PS+NwlCKpruZSRIAwDRTXCFI335JSMLZmC4s7imQcJYMrDU2YruCY6GIVaqWkHK0ArE3RQCYvW6lDVQiXOtHLxndkQNXsrqo4uFm/x3hXEKuXjo/6nzabLNDfY4q/1w3AH2/0dWliLvv4g0k5+y6PGXgtbGrFs3tsummo1946kuaBfA3hBNKMX0IIe1oPqdGTkhK/hJd+F59EnmEdUVXE4YGB3YbOwZ5t9WJS+ke3qKbybR8+aiJLRMoY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f771c0-e483-4d7a-a536-08d7ec999cd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 00:01:20.7051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIi1wuMcoCyisquuk7FfvtBgm5gmN8vy/B8zMm11nGVI3rySuk+gDe5ubIOOgDaNtp5pHMQflL3o1g3yqts7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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

A few small patches found during DKMS branch rebasing that were
missing from amd-staging-drm-next for no good reason.

Felix Kuehling (2):
  drm/amdkfd: Fix comment formatting
  drm/amdgpu: Add missing parameter description in comments

Oak Zeng (1):
  drm/amdgpu: Changed CU reservation golden settings

Ori Messinger (1):
  drm/amdkfd: Report domain with topology

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c     | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c     | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 include/uapi/linux/kfd_ioctl.h            | 2 +-
 7 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
