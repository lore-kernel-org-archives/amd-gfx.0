Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DF7D374B4
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60FF10EBCA;
	Fri,  5 Dec 2025 21:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJ/ZZqnZ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728F410EBC7
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIK92PZylQqmos93UhQzTKXtMGh5uZ9M7Ha445Ibm7QwtfVhSVb22aOM9PBlE1Rzk2IS0xda/2/JHnBCqx+fKzLykVy+bg3BIgpvhqpwTYA3L6F07Wvc8us/YnPes2wm8hOZLhVxHWqiCHybwxU6o2G5JNXOAohl4/0PjzmKfp+ETTMJ9Uc1FX5CvDW6ur77dMEYPxUpjaNFKUPfEtn7lk51dg3LUcHBnYNGxiOLUky7H0Fmk/xfJB7ad88pzHCj2N7w/aOxq1f1CKKO3IdUorpf6fhsWy8jDM9BpRJ2UtQEb/oZ6/az7Ge21EpTGD267bJnfd/AKbd0eQfvkedJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JJQCysHF3WrpnkedftskUhywb3nGIGxMsMGoDHg2GU=;
 b=FVKKjz53EgF09V4Hj/7hX2bV3unodV+FDnx5FBCRiFg38v8WEJy9grdlTNK6CdnkozMx0bdgKRM1DzCBIIQodq0i6SKncbThwMmB8l7iSiYZscJl2ZYJF6Acybmv6Lq5f/+1j81euJueKCpbKEVcAUAqXUN/GOyAZ07eXl1faCqCMjjQsBhP9bNHxjqDumRj6QA8GJpM8D1+TKMc/1r56Id0o6JGLcQapu3iisY5UzGBwHHtUgneqzvLHdJA3hgVglNWoMZxekYcr5fPgT4rgKazBrYpA2ymynLfTcjSMdCdYpS/7mAsbTjReuVnzsyL9Js0pHkup5+MlPC2jg7E9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JJQCysHF3WrpnkedftskUhywb3nGIGxMsMGoDHg2GU=;
 b=JJ/ZZqnZcit9b1ACnu+E1XL0Bd3JAMLD5XpvvEN8U+2kTSNNF6a55MhHEVP9fj/2g2i1hR3TZbteQvND3h7m/vWyji2roTr3Dw0dhdE+FLKLnDxTDBTSSMPq8eNbPYJ7RM3vXlrGnTTXzQm1uyhNLDbvqDgdPM81rW0kgEo5viM=
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Fri, 5 Dec 2025 21:49:48 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::db) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:48 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Export sdma_v7_1_xcp_funcs
Date: Fri, 5 Dec 2025 16:49:23 -0500
Message-ID: <20251205214926.146844-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a9474-a797-4a9c-6084-08de34483677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LJuqTvxuhU6vYFGga8M3oe4Vs9rg60Y0YhTZX5PgsTnA+HAWgxPtMakIwyHB?=
 =?us-ascii?Q?sM/kAI9FzCBzuI+wite/0r9sD9kaSSC2+8FNSZZT+IdH3Iu+hY8tCICTRoCl?=
 =?us-ascii?Q?8R/UWgqD1xY/GUMZxFj0mmmFN3nTwUT2f3NORgKXuArudbr/OTMIWVe9Bk/+?=
 =?us-ascii?Q?gSnSMw9RTC6o6J024wdMiT1x2qMrYzyOnG03OF6Oh1APkr6TIzQcL8rId4n1?=
 =?us-ascii?Q?aW2HKap3L/rlEeHzJDCnMnkLT1CCV2E1v73CgnlXJ/n9igCfLTIii2adwXaR?=
 =?us-ascii?Q?766lMZnxwIKtLCBVZeOhyl363DSPho53AXJRRG6a+wbGoeoYtJ2KrQkWh4QV?=
 =?us-ascii?Q?RxrxSaybVIfxDYv4Qyn9D6lRjARoREkB+62a7Ca3R4o6aJi2gdxsFrKvrg57?=
 =?us-ascii?Q?Sc8dbByAlIylc+IXBH3TPnQWrrmuBLMTVUc3sRXtfUnYjdq2uGEg9doLwHEy?=
 =?us-ascii?Q?SYU8cgCP450p+kdIgXhPFzU0Zrcpnkf4b8qtMqT4XDQhIHHlzLhp6Q1uy0gg?=
 =?us-ascii?Q?JmkW7gOltC0zJKZ49O8bTibxJgielaqVuMrW2EcMLAdEjknwxXUYA5cjAihy?=
 =?us-ascii?Q?Rk8NGvQEPcyBl/NWbf0fKujfOyrZ6ejkmVpE2VtO5Ye58tMTnNaNoU2gsWdE?=
 =?us-ascii?Q?+SQ6+DSXJh66cLI2YzEXAlEXTrYmy7vL0x7AbNiQ/zWBKgSIvi9cyhgzRZ77?=
 =?us-ascii?Q?LZ44WPEDH5V+vu/Q6Jz66RxA9rI/NidQGU/UffZAvBQ4A21dAO5/zVVS38BL?=
 =?us-ascii?Q?kW6o23d97nr211fl12uJW8wrEo7KBUZJC7tmhurfRJAH8A/vSpVs7/YGZnnJ?=
 =?us-ascii?Q?F4wYLm2KiHDBJjQZNRL0NNv18Xq9jIw7SZLc2Y0RzxDlswji8g+aT9EmoWxN?=
 =?us-ascii?Q?pUYTEExuf6h/w52M5vwoQ/XwlAn7xsZ5NM+Mm/GPGAvhG1p6xEmhUyCJHTAn?=
 =?us-ascii?Q?dab92iB9ISwAODOXSt+PEaWWmcPsTpTmI0THXCDzFH0+KEXz4hIUVa0JM5wB?=
 =?us-ascii?Q?VeE8GZ6JjTEymp2W9F/hhIC7py8+xvZiKKyyE9CsLAcBKAqhQBkSufDqb4Fv?=
 =?us-ascii?Q?8L1YxJccos0QIMVjtr6NfTnHtlsVhSZajt1NT+LZy2RNCJ/4Eu1pQkjFPPZt?=
 =?us-ascii?Q?SHZqqbvgYR6iHrexHUXixeonfy3+VUvttANaPue9/gAE4JKrUR5xEuS72vbu?=
 =?us-ascii?Q?AfEF5YPrmRboXguSO/JM7EVJduQKJirV2uvdemxhhYcsVF8pYNcGrN8nzqeJ?=
 =?us-ascii?Q?nn1a+WJxT3D9Qu7eMZjIx3LMRuUwWVGQSnFsCJF+80QeIr14dbg0tHMcUb8s?=
 =?us-ascii?Q?V2SN/NnvHG+gWJVVNPX/gbnOkvCPfdsVPH09MOPg7HfcZeFHcTccy2/8yGkP?=
 =?us-ascii?Q?rzlAkaxObO1OdWDAqkQkmEh39kjDv7qhqSKYQcW2eZw4FPZUwYBEng+SHVN6?=
 =?us-ascii?Q?6CqsRoWNCnXBTIPCSF4MCoqG/lyOH8leTFi89xIeMCUHMvfyFG8+iAbiRT6W?=
 =?us-ascii?Q?7QxFJbRwaMfdV7etNminxqzp8m1XvvJKC++kAuCnUuVpKICIjf/rEzUcu6WS?=
 =?us-ascii?Q?RPpfmiO5yImC79xubYI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:48.8475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a9474-a797-4a9c-6084-08de34483677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To be used by soc v1_0 xcp manager

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h
index 609064f1299fc..1a07ef09a103f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h
@@ -26,5 +26,6 @@
 
 extern const struct amd_ip_funcs sdma_v7_1_ip_funcs;
 extern const struct amdgpu_ip_block_version sdma_v7_1_ip_block;
+extern struct amdgpu_xcp_ip_funcs sdma_v7_1_xcp_funcs;
 
 #endif /* __SDMA_V7_1_H__ */
-- 
2.51.1

