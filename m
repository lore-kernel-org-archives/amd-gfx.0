Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB71C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0543810FE2A;
	Wed, 24 Apr 2024 08:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fn0d3j63";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F8610FE2A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAoC9r3p8RpPtSkJEfLzWMnorxVLik9eaFB0Z7TxBKosL2q09mgVVOVQIwGKFEhWKXI2bOIj9kAJ4xW8joUai8TxGXdOY3HDv06cCaJ4lUudKH9XX1tZ+yYt7/lnNFiL9GlRq2UWlH3CEhUP1x5rSLCvwESAVRdQbwU54aiBndCwzLrCIHPtc09SAReFkM/x92NCJtBPks3a+mtYEwhxvtBObNEyhgP+rjpVkLug3MUtutUxXFmKusUfq9CEdwugF2X9NS9HF62x7qeMMQNKJk2Kby1CnZ7ZJcCp+OLz9zerXURTirY3KpNxJHLUAdGT9ZWzxH50GKmzP2grsaU+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kHoWQwT2DX5hrlC/BdUN6sI70w1E9Xbgr2hTP1w8EE=;
 b=VkIsLyNNWLDa4eA6RUSbnQItfDC41HglCC6g4WLRvqTNxIgCL+RIt5GjcjtOmrfptG5W+yxypY4fDfEfKeQXcPzYMFwF5Qp/f0N9uOVBq+i86FLcNMNFm/ASuBUS9T9OfYDWIhO53AWUHmap3uRsZFjbNsyZm9dmhhEsKQEhpe0AFCVbDbGmqLJbXlf20tRiwll2bD3u4EzbeAXxlw81/xPCVC1/rsTYMc93WfydmosxdEksPbgQW2xfzc0Xh78fxMMnEciraeLYAs2+lfmW4C2QABlRB6cDM4RkYs0G4tIfPaQsLY1CubkN+bn8FwbH7AvU+Kgkw1HOyIQKUSdTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kHoWQwT2DX5hrlC/BdUN6sI70w1E9Xbgr2hTP1w8EE=;
 b=Fn0d3j63xneqwjeegfeqxHuaqUcvBTjbRy5t3efS+lqb41rRqjMEXRaASektnCCgNXvkobn8mUY8epnCmo9DiwaImdNUztpcJp+8hi49M0315eywolceudEPWjaKyu8uRbgA+kxh+50RsbVznkTpHaaMWVWZWskd3AFJVkGIcCg=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:22 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::23) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Sohaib Nadeem <sohaib.nadeem@amd.com>
Subject: [PATCH 33/46] drm/amd/display: Assign linear_pitch_alignment even for
 VM
Date: Wed, 24 Apr 2024 16:49:18 +0800
Message-ID: <20240424084931.2656128-34-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: b15a1304-324a-4446-99a9-08dc643bfed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HKilz72S12+Erab5wWgjVIdR03zswSaYENl0kPplQ8ecpkXvnz2M9J/GENe5?=
 =?us-ascii?Q?d9nhVpFqtTJbQHr009ZRLZLfE/vgdkRgY+ua7v0HYHA1cRgJBnrT00r6QM/Y?=
 =?us-ascii?Q?IQz9VaMYA795wmkAzr5wzTRO+dLYUxGyr2Sv/Vm6gTf2jmKlos2W9yu4H3Kn?=
 =?us-ascii?Q?+e1rTyEJMDS+X0ol5k/QKPRbi8KKVZeKKO+8PYxi7vh5B9qNM2ao5LrkgUP/?=
 =?us-ascii?Q?pqykygmEOILqJtN3OMe2tjml6MlxYs8fN3v2GgV8/UwyOmCeLHLIKLvYTtZn?=
 =?us-ascii?Q?rDNqIy2VxTXPq68jEKXOC7zlDKYjUW8YdvDrpTpIL1/3UG+hiGGEnKA3G01U?=
 =?us-ascii?Q?d/c4A0+lzJ31lEiDWvqk3qZKS46OqstuWgNRaJlwx7QAhsFDzoD/ShRwHM9v?=
 =?us-ascii?Q?VrKmj4SJ6YpqOmSLby74Vvsbi1YSt1de0EE2OFVbUB/YkoxZExNNdWkUeoZY?=
 =?us-ascii?Q?Mama+CTl6sV8MCSEXHW5F4l6E+ep1HwY2iCG8CHOcW0fzG3Dt+r2tmjetpMX?=
 =?us-ascii?Q?Tds+51FKNuxjQzxNiI1dsqIEpB0PbSPolrHgmG+FC3yG/2aZ446XXUH12BnQ?=
 =?us-ascii?Q?OCUm89OEFTz5ZtLWqtucIbOi2LAaH0aA3NRNI8DmbBe1m91wGHPHTV6uVsKY?=
 =?us-ascii?Q?S27WdphhcLym3ZdhnhT41VyTfwo5ZtQF05eH9BFhHzpmDuRS7nm0Fhyr7S5j?=
 =?us-ascii?Q?HHtCDcxvmB4Gzw//wOzqG5x227QcpYUqMWyh1DkfzKL3PUlkt3mMT8aEVq9F?=
 =?us-ascii?Q?ZPHxC1gMcVabqizIaGsags0Fn1wKNDLkyW1eyPxsO/06wAiDfgompULycG1n?=
 =?us-ascii?Q?h8XAHccmutAqLqVkL4sBleFWO+cR3AUUhz9mLLOaGpkm9HnXrUttOTq6SyDG?=
 =?us-ascii?Q?bMmWm7jipzotir/t+955MI8M+trrX7cyP1Qu1KPlRJ+K++blfRIENPCQPLAU?=
 =?us-ascii?Q?iipgVzT2BmP7OdFlDh1vs6DW/Z32HdGs+Sk+t7U++qOXyqoE9XwNWi4XkykC?=
 =?us-ascii?Q?8/lvw2FSl9kqzp7t5WVGbeyNTfE8j6UvDRiqrGN4Z7MtflVF/CtY3h2BtghV?=
 =?us-ascii?Q?gPExb6DHrq4X12yXtZEG8h2UC8DJoer7UMHRuT1W6yRgEDRiWVrQMLXsf1mq?=
 =?us-ascii?Q?I0pyJGQP3MC3J38rgSrFr6L5BSnISg8QpCZTnCjCYeHRWuCnLtbAdy9jTeOh?=
 =?us-ascii?Q?DKMRKIuaa+USqllNRF+tJg/k9n4YmqTDND3xH9Rwhh9lZH335odKJjgPR4Qg?=
 =?us-ascii?Q?MbQ7Vx36rLo7U6wFvOH5N3mwNaOGI2/IKhsXahmkS9Sy2ZFjmVK5jkZnfw6v?=
 =?us-ascii?Q?4lo3VLCOQ0I0/U/TRyKRBwdIC55aJ7uToPXUlClwi1/iw0p1L8cbipa5M81W?=
 =?us-ascii?Q?roJ4ie/YX39MFl5jdubsPpdrXUZj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:21.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15a1304-324a-4446-99a9-08dc643bfed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Assign linear_pitch_alignment so we don't cause a divide by 0
error in VM environments

Reviewed-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e955c97697ff..71f211bb4ed8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1425,6 +1425,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
-- 
2.37.3

