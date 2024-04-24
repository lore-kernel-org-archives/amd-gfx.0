Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4046BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBEF711395A;
	Wed, 24 Apr 2024 08:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yPRTZle";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A7411395A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFfCsjo42ndjg7KMuk4/oFSwto4SjmEv8fiqGJSTym+fbszZ2mU7o1FKSewLLmAy5xq1d4Ox0hUgyPx/q30XxgVdzArf7Y2udYksOGHe72si6iVEmTNrgyJjGhu3r3Awugr7u63C12XPKdZjOIIvr+LKzHsTcI7vO8heU3ObXkr59l7xG7XcCK2B7xjFk4NGphowsh/owUhMSBTIiNJhl7+2scJvWnd0jyWtk/QaupDnXXbzXIZgbMm3ANBsKMe7chkaOfT7cegF7zX5JtHXMFKwpmnx+em6OLzlBX3vmEK2GjbQUEtjhTg8Fg7NDezsI17DF5cuxXVGunMy+YG6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9clcYwajXF+9admqAdcGOHbvlNtS+ZBsMiJ++65zIY=;
 b=JHlfjJbTI3LxuprffAKPwGiGCo/Lw0c1Tm57iqy/GUhWJ6ZUQGheiK+1trKqwcBufoPp/c9Z8my8Sv0bVfn5ngxcJ3LkNMthEdCCXWcyeaG9GfUKs+qi5pMV1skIlVG73v/Zcs32Md4IkRhqGTxGl8bUP4sizAFt6sQ7SCtikl2UZvh4Dflb6M5LGRz1s0zLwY/Gur+2Zwb2YWriDtnnIsKqv460ut9cLppzWPSrF6SnT+OIDUMRWRI+V7o04KsNPRXmnvZWr97lewVDeeantylQlH8uVutxZLb/lFVHPuWHd7jRXlCGjpPum9/wOG7IsfL8kPkk3AevIBRVkrRFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9clcYwajXF+9admqAdcGOHbvlNtS+ZBsMiJ++65zIY=;
 b=2yPRTZleWXPze729RSUuBbLKizIw3RpSA8iSMGA57ORbfuvTslMHTzuZTsj/sn+mHaBIf9a2ysY+Xh/BrNGH/RcAhv50DMeWexwBAq3sA9S9P+rY0kI3aEHX0O5vnvD88HPR/bhg8NgBa6MwPNZRmHJOkarrJr/LclZvLRluYeY=
Received: from BN0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:408:ec::16)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:51:41 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::9) by BN0PR04CA0101.outlook.office365.com
 (2603:10b6:408:ec::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:39 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 12/46] drm/amd/display: Add missing SMU version
Date: Wed, 24 Apr 2024 16:48:57 +0800
Message-ID: <20240424084931.2656128-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d656efe-b52b-4cfa-c7a7-08dc643bc291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yLO5+wSLc1f5xfHWyAoUAotYWXkCWP5n/s5FmGQJcSwFJr4F6+hm8ezpJfSW?=
 =?us-ascii?Q?jhyUpEQhxdnCXdZE3zcBZVkuCZoJFXr+yEk8HET4YPjGcGpHpIGkcGQyTvEL?=
 =?us-ascii?Q?3juRDUbq3w7Ei+Ymt9KIzsfQRP/qGMc16zs66p648enJh2w68j+rFgfsG0EO?=
 =?us-ascii?Q?KqnKAnL0pDAFnefHFWQ8DyWPIIeaQp9xctn/px5ySy2UB7mfvQ+p3fW+XU0h?=
 =?us-ascii?Q?ZoKNhuhoIcaEV0tERRMfYFgaJme//tvgOP4TaMzbOPVg3T1fKMev3fEtBTQ3?=
 =?us-ascii?Q?9Zm9H6lwVYfkEI/13N1/84ma8H8yX1BWKvRgmyTQgPsOiNP35fEgQ068lneC?=
 =?us-ascii?Q?/zLLxtGBZtoel/Osal/JAiVNpkp8BQf2Z5Si5wo6qowH/2Ta4XYJYWbWzqrK?=
 =?us-ascii?Q?iOdQc52VFg4QP/zzsEINHouwfw8SCYWvlq3SnwnpSrBeCSIGldL9VoVdz0sE?=
 =?us-ascii?Q?dq91ZKB8CI7qVyqJ+69kMMkvGyuf3UYjf/4h7cbufALbdZwNWWqpQ5gQ8tRa?=
 =?us-ascii?Q?ZlIvxP0yV8FqGdAaNHwFbGJbbenBtFGgys1g8px2Ulc3oIznL/d5Ds+kFykG?=
 =?us-ascii?Q?uZ5veLpd/oFDeTwMSRfO/Lx7I4h9w9W2GyBKQ0qS+RHVxGX5dJjuCHjPlFm9?=
 =?us-ascii?Q?u01ByqLn2E6fddvzuqk/FEGErzmn0q+pK/HFn7XtK28YydvXo6nw9eIl1Z1I?=
 =?us-ascii?Q?Li26JT0UIWNdMN+WPXg3qXE6L7FOt9mZb3SZBTSXm5X0wliBrNTqGELMjvHo?=
 =?us-ascii?Q?TEg0zXoS3xKQB4I4eTdrhU1D7d3oZSJ+eGyhvpyWSEV8l3pe9Q8dftVAwUYu?=
 =?us-ascii?Q?ghj3wxq6N9IeQvGVsRJ7rUGxOpG3wWJuu7LZEhlC9/MWxZOpboc+c93+w/h6?=
 =?us-ascii?Q?Nnx1lM9ApCNYBTm/CryNywsYkrci6gjiF3BAn8c1k7n7mbnUtJLiG/u9jGop?=
 =?us-ascii?Q?AaXhvo6p42V3Tfw4PjjmRNKxYrYWJD1EfCjHGy6WRJk669/jBWoeiiJN6732?=
 =?us-ascii?Q?stAEDUSbqDmX7CCXNq+72myuiaJUTiuTYBK6u+LiDUjrGdikd37Q6aJ0Xagu?=
 =?us-ascii?Q?UwVPB8pQPjUaFvkXqzF26dqCwHepnjH3azQBovSw1QWDtc960O3YWCv/LBpw?=
 =?us-ascii?Q?5sCXHmCVFP8NMx4w/Jx+eJDX1jWGJq7mmWHupMm5HO6QctHkO5zk+H5OwQj4?=
 =?us-ascii?Q?76ZwwYJa1JQj5lh8YZ4m6biArtlumXIznBXpEZR+d6I6bdbEr5gKCip840QV?=
 =?us-ascii?Q?lmJb7jia9hrCGbCWm6VN6/BxtAqY8hfFyUZMeiRzx3f0ejKqHmRQIJfZ1xyw?=
 =?us-ascii?Q?omwYhW2MKFWqRYy4CQx0xOuQRkkVErPiMMINakFANMVGVWjFYP1GqGj2ouYy?=
 =?us-ascii?Q?7ch99Dc1exnvmV4uDWD5hxwxXf+l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:40.9480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d656efe-b52b-4cfa-c7a7-08dc643bc291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit add PP_SMU_VER_VG to the pp_smu_ver list.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
index bd7ba0a25198..b0e17a594ec3 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -40,8 +40,9 @@ enum pp_smu_ver {
 	PP_SMU_UNSUPPORTED,
 	PP_SMU_VER_RV,
 	PP_SMU_VER_NV,
-	PP_SMU_VER_RN,
 
+	PP_SMU_VER_RN,
+	PP_SMU_VER_VG,
 	PP_SMU_VER_MAX
 };
 
-- 
2.37.3

