Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A74C3601A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3BD10E83A;
	Wed,  2 Apr 2025 16:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/eAGxpS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BB810E834
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEw7OMIdeOS7RZabKSV6VYog0bYvf2OF20LrP0tFtPNlwnjX/ELi2K9GyFuS5Ia4Xl5+aPwZCDP/Au29UJhcMA6VTWCACUPPLiFTtBxIMRHw46CZp5vlvx7RR0JfSQG4kUscsxBcCAES4UensFOlqw6JJ2VBfNLht8BdMhywg5BVcWXbCYYFcJhGSNHCMvp/7UpInv68KOewOe8KtFoPadenW5x7BSQ4zYdoyJ5aPUbUIgWng5ssxuiv7+dx8e2+myVd2AvTKNzkhGjzRVmAFtRfQYqLOr7EhYpsJGXm9Quri+EphOouS0AR3Ecpk4sVUtstRVGKME0CNV8t9uJ6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXl6ZhlM6OERiMUlegXsG5jBmXPC2u3XmNKUSORMGfc=;
 b=sE1M3RF2ALvyMNJc4eJO2ffb/fx/mRgNin48BY6QtOzWj7qq4SW1udQb4gDfQNaikLddDwT90mPP76SD/MrDBu9+8mW6KgprtTtlzPa92e8Pyf17DpXwxhQDlo+iXGzm2u5zPM3TowLFcAREjI+Dva8SiJ/jh39x575fc3fgf7W76Ay3JD1bqBrIyTChWcuPevoUDohDvotE5bgrzTksgFFh0mLWbaFUXB3ougty1OOnlBbMUXIa5oKtv+sYPiCkdb5xscQt1BAoHRLv2tVNsZcoarWEXGHE2RGE2P2FcdqvfbqtDUDE8f68WZyOtAKHmduIqy/+Peyx76uX+pWoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXl6ZhlM6OERiMUlegXsG5jBmXPC2u3XmNKUSORMGfc=;
 b=F/eAGxpSX5K4leDFGZIJuN6+b6g02ohJY6IfFr/CEcKAjgrqObQsYrF8NVwzfm/6/SylZ24D63VYnnZ4syq2jV7apB9MDxZECBdiTmm8roekmrYVU3AAfrkMy8ZGedb4uk27s0ekw3lAmzFZPp7gyFAeYEvh/+7BHGvbEZoCrvk=
Received: from CH3P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::31)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:13:55 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::17) by CH3P220CA0021.outlook.office365.com
 (2603:10b6:610:1e8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:52 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:51 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Sherry Wang <Yao.Wang1@amd.com>, Duncan Ma
 <duncan.ma@amd.com>
Subject: [PATCH 15/16] drm/amd/display: rename IPS2 entry/exit message
Date: Wed, 2 Apr 2025 12:13:19 -0400
Message-ID: <20250402161320.983072-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ff75aa-98f6-4c2d-1850-08dd72015dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MhRiaEZ1q0H37Y6/2NJDc9e++jIxWsgUt5iwLyi/IXynTFaNRWKQKgRwEEyG?=
 =?us-ascii?Q?QAR2ckqFTpQ0Un2UIMKCcvrhSgZAw8Oh9v/GGvPPZJcBYkj1gK/S2tRdukCd?=
 =?us-ascii?Q?HRoliEsv8ppcmcOj9liA2OsCrOK5NcHy8ePgu+A1u7oK9nEFshTdd13GpGRs?=
 =?us-ascii?Q?f6RmhAUUJCjFh3EieW6JwLrnmu4AQ6HkBVPb/8IpYTkWA7YSJWuTkAioi7Xw?=
 =?us-ascii?Q?y6MvNgYAqF1jY1KqJqhs5Gx7+1gPsK7T30loqYEg1df525XSfUQFf0/iLmve?=
 =?us-ascii?Q?ZSLNZxLDQzB9iOPyVGUj7QsXH6g55fpQQ6zyrGh6/lcqjE7oZhYK0U1RBjBp?=
 =?us-ascii?Q?CnkBoTt5oZd0ZVRmgE1tMlLk1zMco+at3IZe2W2YrEAyh9ITm91w9plaeBJL?=
 =?us-ascii?Q?bdRQyxsvkH75lfbfQTTpwxyVZxBmv5gD0qw1pGXs4gY7e068y1FdmpC21fcH?=
 =?us-ascii?Q?Liz7xYVl5PVK2cfF1DKnclTsJzIoqfcdWfitKlrNeuP9SSN/QwtzLbaalyFk?=
 =?us-ascii?Q?AHet1HvuaaHqzdBHDLppT1dVGq1pUWpMJE0xgkZ27UOsjMAdCPrjBdESBZaz?=
 =?us-ascii?Q?9Ds/3INdQl7OARK+Bi5N/cEc/Z3+CWyUPKRBL2YN0dopt+2uDqG/Drddy8Bg?=
 =?us-ascii?Q?1WCAC9B1zHM3WN9Xpkgc9suyaS292NwprF0BjmLTOc9bOLKGgeT4Sk/4HtHF?=
 =?us-ascii?Q?1ktbksSCWa5SNgpCe70sXCDVl9iz3pm5JL/gCfMJ+Zstg3xaIisSN8V8Goqo?=
 =?us-ascii?Q?nD88eY9qb5JA6GSA68aoPArSWSgz1lq+I0t2mwo6GxXIDotFkWiuW9q3rWey?=
 =?us-ascii?Q?hPh66nbxD69hUIRrM/57Kcuor7snmm8vl9O0bKFEpBt7UKQCGD7A+hQ/glj3?=
 =?us-ascii?Q?ZN1hkQGozJr2dIl5SYLhE2t1ISycuC84W0T6ck8GhI3uaFuDrb/oveOLkj/z?=
 =?us-ascii?Q?EGbmdNKHBCwod59EYmn6rMPWP0/4iR3XgjgihHzVcnWYZRoav9X3Smsw09v9?=
 =?us-ascii?Q?Y2fWi5HRzk8uJsZUC5AIA5tnIkgnWYW0FLVgvLqc6B/JqLnGaIeT/aFJ9Lmy?=
 =?us-ascii?Q?q4wSS2wG4AMeeKRcxpVvDxwPbv+vLVxP/ShAGPQlnf+7HWSAS/16Gqadi/lw?=
 =?us-ascii?Q?KjZvO3+84WKUkh65OfawdPVZJvDQR1PQTjcvS63yRWMR5kKVmdKTZ0nWesiC?=
 =?us-ascii?Q?tmL6TTbo6t53y2QRKlpD47pLJK+mD92BGOhT5Mg7oGtueh2oSCByKtzwuC2B?=
 =?us-ascii?Q?HYcgNOMXhBRUYhMcTXaRfwnLFNv0yMNsACfyOd55vxdTzHfMrqLnR5FaLDFQ?=
 =?us-ascii?Q?1VW5pxAwglLjEkFo0OEkUhb8JhfQZJ9AfLynYJqkRQboGOtMnJ56+rQyW/bt?=
 =?us-ascii?Q?HdBCS4jIRZxEh13r9IVA29d0gVtiWLFZ5Uy2G2sMlGIyDtVwYGA32q2wg7RU?=
 =?us-ascii?Q?29cve9l3LZqynGTI07Q/TsIyQqgE8yljmAHUl/MRh0+BT3LaCOe/YrjCkzBT?=
 =?us-ascii?Q?gnbJwO3uOvV3arc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:55.1067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ff75aa-98f6-4c2d-1850-08dd72015dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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

From: Sherry Wang <Yao.Wang1@amd.com>

[Why&How]
Fix the confusing entry/exit message name for IPS2

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index f6f0e6a33001..604d256cb47a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -84,8 +84,8 @@
 #define VBIOSSMC_MSG_AllowZstatesEntry            0x15
 #define VBIOSSMC_MSG_DisallowZstatesEntry     	  0x16
 #define VBIOSSMC_MSG_SetDtbClk                    0x17
-#define VBIOSSMC_MSG_DispPsrEntry                 0x18 ///< Display PSR entry, DMU
-#define VBIOSSMC_MSG_DispPsrExit                  0x19 ///< Display PSR exit, DMU
+#define VBIOSSMC_MSG_DispIPS2Entry                0x18 ///< Display IPS2 entry, DMU
+#define VBIOSSMC_MSG_DispIPS2Exit                 0x19 ///< Display IPS2 exit, DMU
 #define VBIOSSMC_MSG_DisableLSdma                 0x1A ///< Disable LSDMA; only sent by VBIOS
 #define VBIOSSMC_MSG_DpControllerPhyStatus        0x1B ///< Inform PMFW about the pre conditions for turning SLDO2 on/off . bit[0]==1 precondition is met, bit[1-2] are for DPPHY number
 #define VBIOSSMC_MSG_QueryIPS2Support             0x1C ///< Return 1: support; else not supported
@@ -475,7 +475,7 @@ int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 
 	retv = dcn35_smu_send_msg_with_param(
 		clk_mgr,
-		VBIOSSMC_MSG_DispPsrExit,
+		VBIOSSMC_MSG_DispIPS2Exit,
 		0);
 	smu_print("%s: smu_exit_low_power_state return = %d\n", __func__, retv);
 	return retv;
-- 
2.34.1

