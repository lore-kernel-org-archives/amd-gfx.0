Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A750C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5ACF10E124;
	Fri, 10 May 2024 02:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXiNgeD6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FB610E124
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7gY02iIu8N11g1VaWs8mwDD/T1J18jK+3U+RqHLYJsB5sBgYCDDlzrpi0yBa2Gih9IAY8sP2bnMst2V/TXSaut7QfclZdffknyTf33rgjjwF4yc/0hCAMwFllYiM9J9eCWud1Qg6TEVMOreNDxC+vzbY5hK0SBdQDH4C8oBImngymnppNDOB0S3S6WJR0L6TMGL9DZEllYL6u+9Q76JlZVznw99hr5jp7VrtTRqjgg4Xso0BKa3IslygyUHvQ6mkiCIkky6mE0zgqcJxgS0RAB3WHP5yepaIzZKb18ZNld4yt2W6fFmrClkNEd99OQxf8u49dcvoMRgLVDG9c82dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=014jTkurz49PW87CSyRYt5kle/rLQWDm/UlGWeFKHJ4=;
 b=M+LBHQqyIjdxa+qxDhFxNuWIFRLOK876DsnzWQ+G0Vg6Fd4CPeZazQgxP1ZtoL6saxebl2p3ol6bk2oRWrjlS1hSzAI8iUEYUuwoxLiHP9NMCG/AL9o5oCPQ7NakzIZiT0Qt1gwGQuhWVSfR1VeUjeFt0eu59f3UbqFq/qRnt4WbRPG8eRkzWGXJz2py2mIDVR/hgd2zgefaJy3/CXpf29/tWVfMG6HqD0678FQcMGzfpXwmMUleAcOao2/CXOpg4O/BWKVk1JJ16HOXOhxRSy6QWXdO65PIcGa2YdM8JBczngk/YC6L8FaVGAnjJMPRxSiA/RRpvVn3YpyKOfCgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=014jTkurz49PW87CSyRYt5kle/rLQWDm/UlGWeFKHJ4=;
 b=mXiNgeD6gYBFExBZ7RS4Wyilul9eVBWg4iWGybgGPEuwAV0ibDKvCZDQpcIksr+z9vc++xJXPnYlLWHAdm7YhiN/q8jdiNOvmezh1teCUjW3yoT2TOXli68MCKUTwjmyvIv2UX4uDt5XUNATovLXnIPcKXx6V0tzpLp81S/9xU0=
Received: from BN7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:20::16)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 10 May
 2024 02:53:27 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:20:cafe::41) by BN7PR02CA0003.outlook.office365.com
 (2603:10b6:408:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 02:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Fri, 10 May 2024 02:53:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:26 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:20 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 13/22] drm/amd/pm: remove logically dead code for renoir
Date: Fri, 10 May 2024 10:50:29 +0800
Message-ID: <20240510025038.3488381-13-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f62f378-8904-422a-5a00-08dc709c5dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k81EvQbkDpUd3BRwyUESgkM597EgQjo8ktV1qpHVNLLAWN5MkBqXFCFKH8Ah?=
 =?us-ascii?Q?CItH3/jD7DVlQsHEf/ZqhFu47DVAlItenOBuaq1mTuArwrx48uUELHE28BR3?=
 =?us-ascii?Q?bqOLBjkjLJUpbIGeRF5xK2II1EfVESuBLX4Lti7nNuj62dCBYoA9HenuGrkC?=
 =?us-ascii?Q?9EQmeIzmtBktH+86RiGhxUOs3qj268cI4nJulKBlMhTewAz05C+fnla8B0kY?=
 =?us-ascii?Q?1MgC4EGHq6I4ccVEaNLfVG36Oo0WbXc4W8DSpwffYeRcvwH2k1nzDmU9UH4Y?=
 =?us-ascii?Q?KKNxdOO4dJj0PjNdeyxbKTeL+0BsE8i1mwbcnnwO9bC7QDz+p2xG+GSDHQTP?=
 =?us-ascii?Q?P8hn3qs2XfI85gPBIeHipMVONmddhHtHSFX2TzJs6ws2BllBqtZf0tgr4Zs0?=
 =?us-ascii?Q?iInHYN5eIvwp4axJVhGr+yW9DLxhF8HF6Q951DSY0WHGDIXpz0Q4CvTM/uqP?=
 =?us-ascii?Q?YdZEyqZf/a5czUkei0aurRKQH9YpVLTjdGS5fWkfqI17zCZiYGBt1JVhnm7h?=
 =?us-ascii?Q?a7STIfsQ1iPsD+c7DSGm+vVtTBv8DFRUClLfTSRzKe2or+O8PVoiC3HJJArN?=
 =?us-ascii?Q?s0pR/xF5A9YXsW/Op7rAtiQ2wCHExGj3MaQOe9Zn/EpFLx4K8T4za+W4cSqU?=
 =?us-ascii?Q?3y8omvzIxsJcasDV+7bz1eDj/bDWmVNuHzhm+G/rqV4GkKdwZhEjEBxuqODy?=
 =?us-ascii?Q?nd9SagQMEa43G2UPBH2S6woENtaBGTpRoZ+4VHBe18DG0ae2x2bmXe7x5drC?=
 =?us-ascii?Q?aXgkR4MP+3cRPzxCDA4A9+dhZA6lYDp8HC77pNTYl5bh7oift05cZHXCpEfb?=
 =?us-ascii?Q?I/mHjMfsfWsZoAskz2V+SfRNtIeFudMTLWNDVlRUtGsFackbPF3RU4WMrsh3?=
 =?us-ascii?Q?6TnZKYHaILbrqB9FdTqgtROGd0p4B1CofLC3JCEAMY8f1CzhDqtvJCQr3zSN?=
 =?us-ascii?Q?yCVfDkuePoHGbqKWBQtj6MQClZyqu3egjwz/oQ/0PsJL91iP4GHTL+X5+KQe?=
 =?us-ascii?Q?SsoS1eyc7NSd2DbZ8Ol6vgUKjI/tkjNn1NCxaWSH4cDwG+yoSzzEC4luWpSQ?=
 =?us-ascii?Q?KzHO3u8M0QbuFq9vNuZWiM9rbWEySH1cfa+ePqtzQaW3y4y5MbOIz+JZo+E0?=
 =?us-ascii?Q?g8fcYtqVp8FyewkfurV1ul05TpqO6rz+hGPjj27m+CTfHCfTlCjPOLzAYZH6?=
 =?us-ascii?Q?Shs/Uxlq+QwJiOE/+NxD3F9Vz9I/v2rjCDixSz7l9DBX+sWrcdM6mS3JlW4y?=
 =?us-ascii?Q?sglwxmyRhzH17qp0x4rjKVjSpRdcgSrwp8xK4jA9U9y7R4T4JnuFWzvmzp0h?=
 =?us-ascii?Q?hujmowFoiQnjCstuuGo9nmiNwMSSGzLraO3xFnXe4vTVcDbNLDd9VQyb0Vzz?=
 =?us-ascii?Q?7hCFECXlcEGT2ZyrWnrDf6tpN0Qb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:27.1124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f62f378-8904-422a-5a00-08dc709c5dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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

The switch governing value clk_type cannot be SMU_GFXCLK and SMU_SCLK.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index aeeba0d95c9c..cc0504b063fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -585,8 +585,6 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	}
 
 	switch (clk_type) {
-	case SMU_GFXCLK:
-	case SMU_SCLK:
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_DCEFCLK:
-- 
2.25.1

