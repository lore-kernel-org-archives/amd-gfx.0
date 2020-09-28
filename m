Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1536AC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F87206E5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iADcMsml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F87206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEF589CF7;
	Mon, 28 Sep 2020 20:18:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D980389CF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkLh3Y21l9tlTvLqmsH6Iif3j9C/2uJCLfsqcqURnhevm+wFpvXcr2AZTZvJBtlvz8Myiu6q9X0PZMMLCFMvqeubdMvwjA1YVPyeN6nVTeArHzn9KYmprd8J5HkCFZlMcDjKbRf2PYwh7t4eDdodbA/qtZd3Obm+x2ikThuED7wPct09zEIKXeW3AmH83qUQ08a4M0SyVNA++IRF4mEVjPfHGyrPXfUTHq6Y/+WwHfM68UKcniO1va4gLnDl8HSWjrgETqK41dXtqxupKmJGlw5ROCPdxouF14yuLa35YYdOk3Feq08eUc//+ogUTIs3lamiBNRGBfmuY/LOoGe2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UUsq6HfBli+xOFP9Iig1DYRdn/dL8XcWdQqAKJQ6a0=;
 b=ZHzWrKzl4C7YolQklS+QUIphMpeFW2PfKSd950m5vZBnuMW850Repytb9Yt4meZZ2RZReJ4aAYbW9diLel4qUUu2amdgQHvxncxt9HgSExl5VfzF8cNdTZ72E1o1M+kw3WiJqLkBxNXXFApySnkVSQ94XPSK/tZTbIwXW6BoC1oxuZWb6g4BV29yWnX96Bt9VmYL7uwVLPz0seTmDSUfFRAt2R2NT+rO+0bBns7bGapae5dKxkSzba0i1PFFJYZm7T33YXeAQG+f0BzSmHxUJ3X+SEwR+WFnASm87jXvPlPm3SI8WQFWJYMwoilMPCAY70P+IJigA+Jst9Gox7+D0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UUsq6HfBli+xOFP9Iig1DYRdn/dL8XcWdQqAKJQ6a0=;
 b=iADcMsmluFEsseggSWQ9wG/i9z2Q1/6hSRKngcwS3OgpJHyL8JG9YlnHluxPcj/nkMSjZ0ehKU5UZG11BqDuP4gQRsMHL46+3Mi3pAJ8RvF/k6fZouBZTT1t+jF0FkKf26lWCnyYmgyZNvI7BPjydpX7I+HgBDJkSlDUujo6r+0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3465.namprd12.prod.outlook.com (2603:10b6:5:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 20:18:42 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:18:42 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix perms of gfx_v10_0.c
Date: Mon, 28 Sep 2020 16:18:28 -0400
Message-Id: <20200928201828.1018587-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.394.ge197136389
In-Reply-To: <20200925201029.1738724-16-alexander.deucher@amd.com>
References: <20200925201029.1738724-16-alexander.deucher@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 20:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9158bfe-57e1-48cb-04f7-08d863ebb176
X-MS-TrafficTypeDiagnostic: DM6PR12MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34655C608BA2DEA38B87DBC099350@DM6PR12MB3465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P9SVZPqsOLtNC3LK1Ob7XZUYMyhSSoT5f+R/L9nFdnNJ0WRI+r4KOteac8cti3VmMXLAGvyGsLHPGMCHH4qnXSzuqheGFPDyPuUZWzreWKtI1dgqa8Hg6Z6lUUa3zKJsA82wZrgvsViB3S+nAvcwS6lsFEgA1fIdekQURspPIx7C3v/KexNo4zMkmMmZNeVuIEotOe3tiKukIRipABBZ+mdaBFMAjh4SvXjCD2mGxYQaizDtmWdIbFLnii5tClOlMTSGjePcLuNQ1b8OLf5YGXtvXdI39SDEoshWYnPHfkEdqPUHR5vW+mN+FOExbM6ikulzFKGwTg4fekFmcWi139e6i/Z2jeaZ24EROGhuwq567XXUzTJv+isRWYsIe8o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(83380400001)(1076003)(52116002)(7696005)(2906002)(186003)(316002)(6666004)(4326008)(6486002)(66476007)(66556008)(86362001)(6916009)(54906003)(5660300002)(16526019)(478600001)(44832011)(26005)(2616005)(956004)(66946007)(36756003)(4744005)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jv+jiK/VLzBnxh+S1i5OKdZwKdZw6aVic52U7XygzeGHZ4tVJLaU0z54NELDcUIaSXFWqpL+zih5pfxgNXG1nFVEfxsxquHfGTL+ssHCAW7EYwiWl24yguajufTga0kH0c8hHWS06UOUywNaOh90RB9YwpVTJzpWa/zCNy2kK8gdFAR2Hf62FhCX/wDIIOTPYZJVaA/dyIEWA962x40NZbmZUwK0i90zmdiWI33sm/C6TrKr8XO9d0T0WBNebZTmkFGaJX0fUSdtZFte1yOm6VEVKmrTlYz3wIFCsn7e/jWwXtlhANiLSbZZlFLRc7notnR/VwB1Y2bg1vP6yAFFXF/KfHLp9lPvSbxELTgnkuAhm4LR51z0LSK8c/+3roSnB7i43PTQM93X/9kmmsVv26CSqLyXq4tMGPGDjDqFx+/3WylPrKG/FHTKzQPBMTJ8qMP5c98EPhTcFaLlU1pZbqy4XiDHFVRwor22D5qFOEm9F+Ek0nu/s+VNMP7m02gfQlYqXsAi0EYMMX6/dGWtU4rt5YGbvA6EMW7DLiL1k25YUo4ZMYpvoc3ZYKeZDyOwblSP4DLfxWOT6mayGbzpP/QUbqm0gq7j786iow5vxNB3gIbnZd/BHzdcJt5kygDsuXMa2xqCobKR0So320HQvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9158bfe-57e1-48cb-04f7-08d863ebb176
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:18:42.2808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs6bbq7tzB2O9hjaXHrugMDDOq9jkBzBemxcZhnqDxAOLzjUvKmLTzknk6DXl4W3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3465
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix perms: a+x --> a-x.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
old mode 100755
new mode 100644
-- 
2.28.0.394.ge197136389

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
