Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39212C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E2761029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E2761029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD39D6E42C;
	Tue, 20 Jul 2021 15:44:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753BB89AAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+f1xpf50BK3Y62ugyKcWI8t/vTZt84m8oyiNEwOR7Be7Q7lLT3NZpnmAxNGS1m0ahl0co1oTZ88PezWQkKqPSFWFmwobSeCABStvjP6PM9rJk6HrUGSmWG1lv3tsFO2hbSDufkj3c2VZ9zASvfRyeIcjIr2vMPhTE17s1VY+pp3GTFHm1v+2bvxOBr4vZcjDbXu816qW+r162FK19bJovDLsq2zGBp0V7VRYKdHEA1dp29fD+Icc8UeNwIKkzxsrki7zJDagat/D2pni+ii3cnm3sLT+lciUISWeS5s8M/S7gCIF286jpdrLi6If5FgEHLGYDk51LKqdGR8gutM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKl+UOX6Gp9U4XdiMx5RxzLueyotcljugOgRX+aTNHM=;
 b=AJ9vKNcLTr7EYcQc7E+34sY6FpMY2L4C6LYXrD51TlwQSbqOyqI4LSO38zgpHRTNeWY1QLw2ldjiwQOmVsxE4MLjWxe5bzwC/cK6siewkG4SGhoUJ1U2sz7eAGOjLY5yCl5xmnGeyJMt0vp++RCZF4jgCU60eKRE79WKpecLSX6N2ZI7P0hzEYU8jLzE6b1erPrGRInuDiNnTY9o2DHM5Zo6XS74uzcR18RFEzYnQHh5Ty8V0Yx1kG5gypRIONt7Rh1gzRgXHQwd1+4fI0w5Zejxpds3uqC/0qUsntqRGLx/qbHSjDD6xWBzTD4RGCmF8YIE86IytM3GHDUVq4rbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKl+UOX6Gp9U4XdiMx5RxzLueyotcljugOgRX+aTNHM=;
 b=FtO0zhx2skyMRaedK2SSAR4vLCIIi2NtNnHN8nsmusbSLi/Fm/n4nSzXFbcIegJhpcAjJXzUYZjKUQ5IdydNsLQ9pvgyJELFzAX5yqTCfwr9xVMIsQS5GpYcmVrklQArXVLdnhzge2oxJ5WSlUzqSnoZedMudxjPJvj8k1gww3g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/29] drm/amdgpu: adjust fw_name string length for toc
Date: Tue, 20 Jul 2021 11:43:22 -0400
Message-Id: <20210720154349.1599827-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e0c084b-3ed9-4a92-a23d-08d94b95344e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126143364DD53D5ACD52093F7E29@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SV/3ixY1N2KfrdGHvYDRJuOqlcySSzZHLLZk1BseBt5z0XuPszigCxREN5FwKvvNwHXqY6s7mktMzcwBzd80yIgIJmQxl+pKNGFeVHErL6n/DbDtkosSjDFujrygZ7N6yyBSUsOgUFC5Tq2uXhv5JzdZPJp9bBwq+7i8XIcBxbn2fvDYOZ6RtTGznFmkkQ8MoGAzH8lexuqcOJ3nQEOzYVNxlbRQ5XftTozCchmYHuEIdU8tSWgdHWug9rJ2sAcupMvFQtdJDk+9S+pbdouaZ3cXPOvW5mVm2qLJegfkVLXdUNuhx+WBmaPYIW9XjSbpq+tfdNImNYWKO+iTugjzcxKiMIxhZyylnrf5vfomP8dhBaZvrXO5hW1vfeQ5I0aHk2ZW1gbylW/yXCVNxaOp4RxvWOCrqZIbdV8i6+/3zfBaRQHDG+1pcwRtRVEKlVJe9GMPavrF9/fMd6rLbeIP2H7E56GNv59tIIggdohbzB69EH5yVv9fCnTmJJm43AqV8jeYaUbY+iTMKerQLMLju0AEgfjRw3paGV7h5+OXoE3NkKhUpHZwEdkMClzIjzxAQCxZGBUyADl8YVc72GIRYD60BaMIhho5cGN1QKJWq+rE3Y0HNgx8yu9NUpTkKdhJpNif92gl6QtdDQTT1dae66tBRYzFkJmhy7oR42Ak17Jstrms7vlqeiCyyWokNNinb/IG09zV4p4Ru9FB8hdvjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(4744005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6LBwWeasPfSs88Nekk+6X0sUt27vrYl6k0on62FvGP2waadkP5/Zj/7X/nt?=
 =?us-ascii?Q?kr0Mt1wT3wQy4VOyJFotwH5/RF5C8p7mCwVt8rUf0Of+JxzaWFAQUbynrjKY?=
 =?us-ascii?Q?AYa9a7S5DN/cVqnZE6/LTLguGeFCsaLRTCl/Poqh6+7tZsiTdsiamH9qkHty?=
 =?us-ascii?Q?oxCV8pJQBc37sYmeaaoEFuExDcIg9eMQBVoXQxyDO3lApPPBAgxAcO2Dbdtl?=
 =?us-ascii?Q?SSv/9inD2+nFzrkYkK1GaQWDqVgoDLPBiC0Lj14I0XYiHzdD5TdK3I/R+zXM?=
 =?us-ascii?Q?jexOvUprPwq8aBhuR3pRYcvrCxGYXNsYiJkwcW2AWyKUWafD+NxXnskxXhEM?=
 =?us-ascii?Q?0saKuShk2leRZUwXcuw+uePmU1OxjeiRRsPU+KJ9LHX3Av3kG9hizKFwl6lj?=
 =?us-ascii?Q?8/cJu5HbUmBFBdQN+EggRwA89p42HDfU/79vQTarWhLS2dQwUB/En/WRSMtB?=
 =?us-ascii?Q?7MDqka0kqI2SyK/gpwEK1gNASzBS/l+XK5V6h1WAfckTemvSREEE1nC124j0?=
 =?us-ascii?Q?sSQZQexvc0Kq3XDRCfZk0fbbYLtwcd7V2OF/9TbblrQGUlrDfIBjg1d2b9bF?=
 =?us-ascii?Q?ePpXvyiMMS1sDwIqtFSRo/+gMyJG2I6J52QxpHXJ7sOvjIWVsWJ13mAA8Mtg?=
 =?us-ascii?Q?cDDO3kdHkXxEhk/cTMUKJqOKFNqoqzbYOLtS04bJ3KxJRUObobE4WyQgBf3O?=
 =?us-ascii?Q?9bGotYs1oGVkhkvM45fN5/k+BT+9FO00uaMwEavhwt3/33t8+jY2u78MTtJQ?=
 =?us-ascii?Q?6Je+5r2c/WlR11tv1B/rKPMwxNmoiXKB2J6d1bRqLtUQo+mQ+vPcB83gJAWW?=
 =?us-ascii?Q?nyr8++QgZpTgTNl+sac6W3kVPrP/jNReLXW3Ri5neceLgSvAXY3arSREbJhw?=
 =?us-ascii?Q?Lb4hcdmfDn5L9SCTJAFcZ9bcgVZtnf7FMkMAML5ZB0jgPEFINVzLJYN8rJXa?=
 =?us-ascii?Q?FfdH10ccljcUXuYgg+blhtxplW8fJTzoAURa+6X67JGIyJCoy+Ik5FoFV9lb?=
 =?us-ascii?Q?3BYuamGOQKLZsd1a8jBCpN1PhakRTnuaC6VsEcipWntgPzB+5xvBV0UQXtg3?=
 =?us-ascii?Q?buitiQn6CzuPXfp0km97+juxBEWq0eM/AVi4gaZ3wiIAXUdn8m/7yIBjWdvI?=
 =?us-ascii?Q?mebAc6B0zX81t7IOioADNTKSfJ10QTo/nL0eZaIbtyBEhCcZa5GGnTdSkcSa?=
 =?us-ascii?Q?mT6m0HWW5bO+jZSw9I+mRS0Idc90lN4bP5HzwAgdOlxsbJJT1BaWTkOyoncA?=
 =?us-ascii?Q?faDRRU5iMD+GZJQaE3T2ozE823he1FCjvawktWqOFIwSE9bC5pPPb4wIcZTi?=
 =?us-ascii?Q?7UiOXTMvK+BqVMQXzj+Ua8iR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0c084b-3ed9-4a92-a23d-08d94b95344e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:05.1824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5+7b8D9W6BYYf7HS1L6hdKtsNKjcz8CHIL5F7/XF1YxIGIfNlKoV7tpPPqNNZaewoILwZcz8113w3YNuMJQAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Adjust toc fw_name string length to PSP_FW_NAME_LEN.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9ddb2cfaba1..2ef4355c12f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2956,7 +2956,7 @@ int psp_init_toc_microcode(struct psp_context *psp,
 			   const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[30];
+	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
