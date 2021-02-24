Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A95C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CFA64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CFA64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963556EB90;
	Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3F36EB7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez8dy48a/E/Mqv4cNGnrKpqvYn7z8Y7Ppzc8vbvWVJGwSd7cJp2tRLy6R5ilF5s0fRL4dB8wqo4Tz0KlABehAOPm07KU8I8kZXfdB5ibxoEVEl7ah7zUDKwrxJImdoNvDR8BDUCeKusK59WjnyWtTJL4keRRDHzgs2M52Vu6rpnmrBAogeObJ52araijH+yN5MGTSQa67eBsF0gyBD88AkSgwG3g/pOjPl+kSiBnabwc/IU8KGdn129ftsiuIVkl7SO3fDLMsRuE7BEQ5PW4GIdPNHN69qk3+r4iaVC23O1EL6zsh3Y7kjNkot5vhOyn0+aIiZIP9Rgv9FUu0gjXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOLmOpZI0V65urz2cHoQmmKGmJ0Vd1SyYjjyaubrhkU=;
 b=dcmtoYf8iDwXGUm74tv2Ml0W5yS3CtEr+96j1XTaUdZSekKWGjDszC8OvT8y8Ek/alSO6WL7gpZW0iknbh/uPZrCRDUOegTECPms/y3MKTEzay6gSCwbiUKnCCCECIOutOsePGHPPuN5vi8SO4E5ZVlV9Q+SVOCETHqKFiZSqKHBngF+EciR7bGbcN3HhoBvx2DlEc2XUA2W9+qQToD6hyOPDoLbQPImT4Yc4OouLRzAX+1bler0oE+orualhmAsH/NYbsF/PfS2UaCTVDSaj8RaiSSFA19v9nJEHqOydzRQG2OzYm7AwYOpgBbs0VTOvf1YRkzTghD+6ASJmLoaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOLmOpZI0V65urz2cHoQmmKGmJ0Vd1SyYjjyaubrhkU=;
 b=4Rfuof15fJJBsRLM8nhbGErgRMoqBi3ZkFJuAgQphcmZAwA7PCpvZboGCgrROCA9uePbqgv9rISPMrm6g7pPH/Y9oho7WhUTZmYg0OdKaevcV8UDE5qGTl192ZGPib7X9E90QoK4G9pTJl4yqWbrIhtKYNcJdKFuF7DGMxmcVCs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:21:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:48 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 117/159] drm/amdgpu: Don't change CPU mapping of on-chip
 memory pools
Date: Wed, 24 Feb 2021 17:18:17 -0500
Message-Id: <20210224221859.3068810-110-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e535e4b8-ab3a-4db2-be9e-08d8d9126cfb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450336A597C6E0C7AE10A7FDF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65dVP6pH81RQvw5KCAX2k4eBag/2rak+UKBlu1WYzGTdrzf2tYhXFusjcbcfX5jkE9wheYI4n3UsRhh6VCUFWIVkmapXZS8ov1gVtKYNM7TkN9nkMiNPctaG7iwj79Nw99bbHVeJGvmG3WrVsmm5vACHpJ64aX4kyHWOvh1nzkrHAPbxUqlhKh5n29DNBwIH2H3JPjwibz31QWZ1cmuMbbo+Lssa2nBKzortd1eNFgvN9TURPXvWWbNndtJmPDAzlPghe2IZ9hJav1BeMOpa9w/phkayRwT1lUQpH386IzVTL47GH/G8q04wpH2C6U7yS7tDtFAIcLvLpV6c2e3wKGICOim2DoxVoRPhdh0qvXEZLedWToNUKYn1Orvl2TvxmhwLHhYN6efsnxOQGkgn2Hd2buveuR7z5I0gTIN/7HBRm4xwHGY5MdfeeLzyuXdFoj7witPqbVtglTr+yGXL3kGdhgXwSjiE8l/QuMkYAubxLRm3yp5l++K920mVavXPfXxAMXEM80dZ9x9ZDIrzcvgIC0DVgjR/VxhlDsUVzffusp04ToySQBTVbBNkmyd/dWMYIH0/u45OGhQC7mBv6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/xuKhDSRzeRZhB0nCGaKMOpeIzmloPuNuSYiBrfmAyq7XZLm6E9/gZeLLjbO?=
 =?us-ascii?Q?8Hvgf1nLfSUQU1FJvut751+b2CLH7srQguUh5DJLeeWq/xfupUp1cPoBRTN4?=
 =?us-ascii?Q?OMVjh3mYDeWMW+RulCi0aZbCUYjS6S5Li27aiWoJJB7Cdev2pnzcASyFxp/H?=
 =?us-ascii?Q?IyXIWFOvBodctR7hge6Ui7feXf201wftjIUwVqdOFOw8YRUQRJi7iAD1iPW6?=
 =?us-ascii?Q?z/rbtA9CAJDKLckVSu6kR9BTRUl/GsVaeyEJvDrZRAGHEExf3ku7HNBVaQ7H?=
 =?us-ascii?Q?wu0ntP3lFUgwzRgwkmS8RHQLjNFR9rAwXvXVi+2DmxEl7gUgRQsKqRmpqTKr?=
 =?us-ascii?Q?bmUJKKBCHfyEkHd3ByA+crpljK3vwuc6xHtxdtnya23eDqCVIdmYEHC9J+TH?=
 =?us-ascii?Q?2TQR5zAQCIQRvWMfN0VUtNNK9aIDgxxigiBouJV+mjyksgb1BOwgMDGj84Yg?=
 =?us-ascii?Q?GV6iky40dlTjc3BVwX42/fXNAv/M9OUgm2D+zsmia3RamFdxwHIiV6GxmCoC?=
 =?us-ascii?Q?mQW35lR2SiYe/qYcUgEynfO/u/jK6NolV4RrNOFws3Hmx1gSLlcpQ4ymxN3v?=
 =?us-ascii?Q?qv/0dulKENFqtYSEhUnUKqsKS/rCeEGiv7Um7DOB5lT9bBlzqnsezcaKSmw1?=
 =?us-ascii?Q?ATa0uua7RmTVP870horkkLZulrlMU+ivrBQ7xRb+DKRxOaS6FeD9xjcDdtlx?=
 =?us-ascii?Q?7fq2qbCF4F/BsncyboOdYXF2xbZPsjhYDcyNwdSd3yS06mD7k8izCnMd2sWO?=
 =?us-ascii?Q?AmZlW4oiiSsfZ6Zn1AMEOB6QZV8hngV2t+79cNgUxg4yREnnPY690b9uYBpy?=
 =?us-ascii?Q?vVNBcworZp+TUBxVmVFyGwmEsAn4q8B7+WgzX9yQC++0U10I+ZNwpuSEtU2S?=
 =?us-ascii?Q?3I7vvgC92ae6LKSyAqyXY15ry8HWGC+8GrRY3IqQHBUoEeH0r1Z0lnawkEtB?=
 =?us-ascii?Q?j/szGUR/Bf+rR922H5O9yXYulngX/RJvjjyneNTWePeo/HHnd8fmBI1RQWEK?=
 =?us-ascii?Q?A13YOv7S0dojI0DQZuY6pA+JhTJM+YT0onTDFrjlI/DtcEF3NT2prtdE+/+Q?=
 =?us-ascii?Q?kp9fXFvuDdMoCfDix1v106vb49YPYLNnGNDH0LQOEAtBBsYIEk7zSncs+V/V?=
 =?us-ascii?Q?ixmidqDbacfrmyAqOPf67lhsH+dxUsblRbqN4Zq1mMC8MiRSZWWd1z59rCo9?=
 =?us-ascii?Q?IPJ4tbCRC1IFwieM98t2GFxtL3tr4fP/RFUjvCksPFVSBtxWoUDkOedV6OFd?=
 =?us-ascii?Q?C72rDmo8f5LiTWGr7nybBDCc/FC6vL2Rc6CEHxXTLJf72THUj35eKo7pXLwm?=
 =?us-ascii?Q?EVPDJeKfO4BTMfn4/CG/hqe2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e535e4b8-ab3a-4db2-be9e-08d8d9126cfb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:43.6271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /90kmtoG+2v7rjR4VKLa2QLI8J6xih5w28hn+BVqMJUGjjWKmdqnQjjI/TGWuezjLUBLMQKP83Oo03tTcQ/dpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

This change does a partial revert of this commit

'drm/amdgpu: set CPU mapping of vram as cached for A+A mode (v2)'

The on-chip memory pools are not accessed by CPU so the previous change
is not necessary

Acked-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3a2a922c6c1b..1118142f783a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -66,19 +66,8 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
 				    unsigned int type,
 				    uint64_t size_in_page)
 {
-	uint32_t available_caching;
-	uint32_t default_caching;
-
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		available_caching = TTM_PL_FLAG_CACHED;
-		default_caching = TTM_PL_FLAG_CACHED;
-	} else {
-		available_caching = TTM_PL_FLAG_UNCACHED;
-		default_caching = TTM_PL_FLAG_UNCACHED;
-	}
-
 	return ttm_range_man_init(&adev->mman.bdev, type,
-				  available_caching, default_caching,
+				  TTM_PL_FLAG_UNCACHED, TTM_PL_FLAG_UNCACHED,
 				  false, size_in_page);
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
