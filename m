Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A12C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8C664ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8C664ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93AFC6EB74;
	Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA4A6EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC/G3KjIyblYAz5hlCyAAj8soshxSZu7kBpjS5YGOcaJJz+i7oGf7FDzl7LMIgAl05IyeoOFb3dHQcXuU7FWzYF+7SmiuNmz+qcj79OZSmkmVL8+9ThbbdZJmAnagc+nia+7xTVdO3rskXzdySv+JyaZYSirt55GwUbl2S3kVWJaCQXTMSeeOvfnGEKFoWJ7nABFCYpbrtRtRHlixoq3oV5z9ph3mlAqBLnarg0WfH5TiiJf6DqnvvHjb8SWRz7jSxFJTUOZkryEErI12GHiKaGImsXfS+1QKWXsLiAT82ceysqYiT7ef15uM3gWQMHbjQ+0qnTcYPm6yxuHaomNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnPdKB/ZKsrwE/FPWJ6/xgUku9rfhEbzERg7wOH+rAI=;
 b=PNN9teIV8bCXd2p4LLAcYNPLcJSQAI/ZuoGBwXli906/z9M8abOX89NFsWk27Vgs3ah+nHkA97TzlZFua2s81Z9dx1Z8/w4huWCPIWFMnYBuBIKhWu7hYR76pB3NtHnYEBCh9TLnVWinhrPsHChbGuS5nd3bVHr34LPbMUrYZv5MyjnQ51Eu0eVYFUF1X8X1VYFcHyF2BVPfTKjl2KKKtR46X091lAGCibu+W0a+cl7BaIMoSjO7q//jiE2rPNBA1PNZC4BqMyKn0ZFMCj9qgscJJqVkBOby7o5NDGAu2zY0qfbftdFx9B2rQRTJo08OBPO9ai2bFaXD7KAwsI/CCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnPdKB/ZKsrwE/FPWJ6/xgUku9rfhEbzERg7wOH+rAI=;
 b=4taQyBZORA58U1HhnvhIgKK99AB0YgBkF6EN5Xgs13Ssjc0J7P2SZs8o5ESOj/ldKZBgWMREXzta7F13mAsoiUbt/ee0tO/nFU6RJz4k0o4rvufHMfi45Skq41MDq70n49cwhiIH0mhTrQ00XtG43IzbvGQIOFWNxsZojlcQoGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 087/159] drm/amdgpu: pre-map device buffer as cached for A+A
 config
Date: Wed, 24 Feb 2021 17:17:47 -0500
Message-Id: <20210224221859.3068810-80-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0314f566-b7ff-4041-bd90-08d8d9125f47
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046B6D449A6A4E4D7F55643F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NfB5JJwQnK+1o60ZdF0PuRKjzxEZQfvg5c6CyvtSBHM5HpGd+qCCaFiNay6rgWbpkQ1+Y9DCpFHrLfJ0nixU7BsdDIuSUphwadktLqNO7Q/K7sFEsY37Av5AffF7H4HzaALQBNixZyZ+aQILDHMx5bpP4W7l+8X/k+2BR663BSTHcolZQxIek/atNBhMtpIuvFABaTVuTKKJXEVxen/86DrHlSzy1eP2crXN8BOD95eneUZi4SL2pJc2T1QBpiKcEs+yMX6iGVESxu3zXVMmUmLTO19uEIf8eWpD8zf2EtGgEVJ9hxW5uRwLFM6turGXcgvZY9CS+jzBGC/m9bw7mrhVaFZZWgS2JHaAgtUOBonpun3dYP2mO6aTnyoMkRtQkNbVRf7TMiagjzXe6mUlv8hWA4iWncmMax5GQazyuzekbWrMzRZ5fh1/qhE1CbXaojIpy2B8qCFvDgFVrhCMuUxMhZES4+1TyY1FQwnQb5tFu/TOjBbJkkuMZr0t/aUiIJFQcueBaV2nWqYg3BTDNzlZWa1l+fcYxWlWGOmu31gcJBxfZLpW+frHbmxxzB/+8rofK5vF/HbWorY7IFvrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?So66dnjKTyXM2FPbN0foeCEM67TxJreB36pUTDGbkKpUv4G70iLKh8R0taMI?=
 =?us-ascii?Q?LaHfb7qJqn+ZoDHbeARncgZmtvqUGvZ/ikuC80QhK90XF3LgS7aG+EcyCPHj?=
 =?us-ascii?Q?TM0HTEz0Vcd80D3QBHJ/mAvWWXfN8I9WK/w1WS539wdyGqATaEH8fbVdL7nU?=
 =?us-ascii?Q?egUdR/8S6otMlntUYeMHmDPqT0P0ekJmMfGtiJWxk3b6viGg7ggNQbMRkA23?=
 =?us-ascii?Q?tTbAAH3Mk5MYLVn46JsvMO1rN6FeAGvbxbeXFVcPLMfsCr85jsslm+EUrdmJ?=
 =?us-ascii?Q?8WI0vn4m2UYJx5Cu9vMTjDMZXU3RWr9qPtqZ2A+AsGXKnX3XBR/hNXy/6fVj?=
 =?us-ascii?Q?XGSjPhsG+0x1dxgfQvNj6xEzSEuW2PPqKzbXZlnv6t4p7DgN21sv/ohidJV5?=
 =?us-ascii?Q?PNA4xLLNQO8mAPe1JujJa8CSrekcoIqkc6PtDi1f/cmEwVtIVGefTy1vqVnU?=
 =?us-ascii?Q?sSNUNYFJ8SO/4O5ACrrV28SUrTnJGV2T+LPCyFOM7Z58x0c4q92Ve13iKQVH?=
 =?us-ascii?Q?dEnCH6tKfU/UG7Px3D2RjWgIfKzU17vs0oG/HaGtYR6qMIgPyKcLuNRcEyU9?=
 =?us-ascii?Q?m4YVpcpmX/hGGWiB+jFk0tsLlXOr8tddw5SuHqR582vF+FkL8QXesN5GTTzk?=
 =?us-ascii?Q?YQbCpVtQYQMcIy54xmfs0a68YiUUCt1jYo44UYx8DTYfcih7wmaINx6kbg1T?=
 =?us-ascii?Q?j8jxrVoBXMS79lJHYZ8C0hU5x8L67JFz+fXMu2DiafbzXs5yIq0RtfLLs/r0?=
 =?us-ascii?Q?AJyOMTZG0AXzb+MufttwwprfRwwXKl4LPZnAZhMtbN3bQDPDxHk9P2aIwyF3?=
 =?us-ascii?Q?vfUHNSlK8nsHO/aqEa6GhcSGdHZ9Lk2JAUui7f48pGps2mU67ezgy9JbMjtn?=
 =?us-ascii?Q?XJ4ciqKJD5A3Qb7tGMDOlo2ZRs595z4YMpqgUkIhOx2vJFERjscaccFw73MI?=
 =?us-ascii?Q?2yN547kzPlU0WXN1K58MxX69kr3ShtUc5a2Y8IX1pOfflOkZoPUTD4OcT1Ik?=
 =?us-ascii?Q?fxke+fw1iF/Bx2XF+ah8KUs3yOtQDLmMGAS3cIRQo82j79kTUfebI4J8wffQ?=
 =?us-ascii?Q?Nq+zzJqeL0Ixt48X45/XJgIZjQn4ndc3no+r/T+AovivrhoxtrYE4tJe/BGk?=
 =?us-ascii?Q?CaGDFrg1Vuppsct4HjfK8DVfkW8socC2KQTLxK3qmMMP7QyeKkl59Tc2lugf?=
 =?us-ascii?Q?qsRBtYiIdhsuzuu+hGjdbIRBhYvLZVbd3UccvL5NEB2M+VHQJobyrzmTRRCL?=
 =?us-ascii?Q?JLTlztn3ghVNo9Rna/kguRC/oA3nqmwKudYb6J9CayQePWv6lztkvGZjGcJx?=
 =?us-ascii?Q?ApLy6QE6kJTipQAYDPiFiBxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0314f566-b7ff-4041-bd90-08d8d9125f47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:20.7774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkL9XLpUhDUq0JWlYNeH/6NdSav/cyS57Wa86Og5AMMMBVtnk2JHla9XXWZ8C8v/l4UZuRzEEATpEK36w2vATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

For A+A configuration, device memory is supposed to be mapped as
cachable from CPU side. For kernel pre-map gpu device memory using
ioremap_cache

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 441799f0da05..95d9ed411520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1917,8 +1917,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 #ifdef CONFIG_64BIT
-	adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
-						adev->gmc.visible_vram_size);
+	if (adev->gmc.xgmi.connected_to_cpu)
+		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
+				adev->gmc.visible_vram_size);
+
+	else
+		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
+				adev->gmc.visible_vram_size);
 #endif
 
 	/*
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
