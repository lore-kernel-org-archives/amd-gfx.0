Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75781EF070C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A94710E2D4;
	Mon,  9 Feb 2026 04:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4PwzfaL5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9703810E2B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1X0gSu91PWYdh3UYQB+RGMw4F4FfgWEILCtnLWbUeNHtyBA8YioDT8ZL76f+Eh096G6tXMGKPGfVlyYOjsrKW5K6ORS7P6wV22DPssdypZLpnuM0SKUBSTyZSZDATzkLpsLjrCJEPfELvYq/AibHcehKIq78a05LlFTHx1pCgtvyFl8vKr07EqHm7VYZevlkadQf1kI2B4ooRYLoSYHMSDelUn53wb77dcGKBTVRHLsEDTcv0UtqEJUjlJHUaIRLmmcf/9h85lHHaPz57adIBHM596zsveR7YXlOq/4Nsxpv2wYpaaFNFPJOEybPQ7yvV20RFdEeaDz3LmSrxIYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QCo/XrGNGmvHcVA8N228CswQsrkvvo0zno8yM2u+x8=;
 b=uA3bmljoAOGLT/zmXy7vFXMYE7/E8HFVNLfSRjMkBOVWti266BF+K8dQpuyAhtZijYKdFiNSZheKeAtXlyIyDlTZYrJL3S8aCL/sx3+TXdCYVKIMHi3d2HnGQuJcrzmihnHQdAm0ouHPtNSSrNUn51CDcDNSDGLKoSnPYFg5KBx+kSZaIpITZLVtn6MSkhOWaqLnQT6KQjoLgz/piI7DJgybB+LJXNbKizx3jwhmFvHqwOKBJCv9r/q/erf2Tv8A7ZivvRLvena7QO+rMw/CigTdJXMDsvD2CB4rU5hOEvh9bf3FAy61aYjZ5cpynVJYfY3d0Dar6vT2dfGz0zFxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QCo/XrGNGmvHcVA8N228CswQsrkvvo0zno8yM2u+x8=;
 b=4PwzfaL5ke/61VpyMecf1sh9Z+TW9Q+cR72bY/Vi0NjJ8ZB1s1m12QJhe+S6Su8nTri+M3fdqRklsCHxbc6dUnXtcOQHdQLL9P/EYd7Gfze1tuRDV5+sz0Q+wY3OZfFXv6OvCMnxBp5TCleA2I6eetSRN9d5dChopF4Yuely/iY=
Received: from CH2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:610:38::26)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 04:57:29 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::30) by CH2PR05CA0049.outlook.office365.com
 (2603:10b6:610:38::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Mon, 9
 Feb 2026 04:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:29 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:27 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Mon, 9 Feb 2026 04:56:49 +0000
Message-ID: <20260209045649.59979-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1379893f-f6c8-4080-f3d5-08de6797ba62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dg2qXTxmxPcI4hwRC409h78fTsjyhoTVMgtGbsBbDEqMhQLDenFdA3GkVyEV?=
 =?us-ascii?Q?50vYyWlqBeZR/dFxstuKCESQC684qtoLnZ1gOVODeFqrzXsoE0FHVoYjmP5a?=
 =?us-ascii?Q?0FVGRrLMY50iydHz7txlQ6MvGlOswNA1vyntPO55Fvbuck/iIpGJy0sFgYCo?=
 =?us-ascii?Q?sB9levNt0PRdR5FKE1dU0RXv1hZbT2WbLTlH1w4jmieXas8X1S7Zlv0o3FdJ?=
 =?us-ascii?Q?QwHCmmnc2HeKbs3bolgL+lK/0/XqpCH/2bE/nhLgQ9ilXjGeaOqKQQYE5War?=
 =?us-ascii?Q?/SEGYdgmHxicKHIMsk4nTZiLtYubB2hXqdwgpGZsdfGDLn4GAOPAlwxZ/bOM?=
 =?us-ascii?Q?p7wuV3pfyRPNi40W8ONtQn/JHKrIJ/NrzdsTyseJOYWNOOBBVQKi3pj6Vkz7?=
 =?us-ascii?Q?Zv35ooMAF2HphNIKhUr0gWZ3H+zlcSmh5D/gE6221jShJRlAN1lA4qwOgNO9?=
 =?us-ascii?Q?6I8YOECkZb5RlC7nJ04+trnxI6V2b6ZNEH0iAaHQ9BHLRcUnV73SPD7eqneR?=
 =?us-ascii?Q?1kvOzMGQLoV5mE/oMZTjS0+0OBc5Iq7FYN4gGB2ypABx2MkzwV6TYJdijjvF?=
 =?us-ascii?Q?00bpymQVTpORQxD7bxTQRIxOcsl1fyBbSBUIesbFMZwncwNg30WWmJpl6Obo?=
 =?us-ascii?Q?FU/BT7IoyS/2EL/A+D7KFa20SVZmIXrPo1EC1JwCrKkNKQ8AJ8qiGaJakE3d?=
 =?us-ascii?Q?1Wmodum0onEwE3b5a7RieiKI0dWn6RAk+swqZ6RzzgovM5yYa4ee2GuqiP5e?=
 =?us-ascii?Q?sPK3AFSZavCt3gKsfutTa/rf/NtHyjGg6P4JZ2UmTjLPaDc6sAQ69bEk/PHD?=
 =?us-ascii?Q?+XI6CMjjsNTWj3GVNky7biWY5ssNqlmq4Ra1fPx3ZCxUF0lTx9rUuWDgyKv2?=
 =?us-ascii?Q?52YJ1Qm0/AKXGoOzocRPfxX9IHbPQrOiL5F+lCFOxd6ShYj6CSo0R8YTQhFu?=
 =?us-ascii?Q?QJxCVPukK0LNsSkB3M+qIWeTfKJ1LNfvyAFgKpPSxwsidf4kyfJ6I9jaaMb3?=
 =?us-ascii?Q?29avf63G1NbY9y/PBTfVlqna+H3mekKXSFDXa+cxqLitqXX5oanc1RkThjvc?=
 =?us-ascii?Q?az79L2qKxEKS2cdeSBTK9BEUhXL+J0bEY2X8ItsUnmepK2bmY7DkIlHUIBZF?=
 =?us-ascii?Q?+xwUlGLY9tpphQBde6Oz5sGtdUNwIT8UmXESnlbXxfIoUWnLpr1FrebBX/Rc?=
 =?us-ascii?Q?WU2ZMbgC884RPDwe4KOz/zRkkMaPjROmz7ZKI8wBFFuFMBRNGQODGtjs2Wf7?=
 =?us-ascii?Q?NdPJr2ilr4zQ4jYhiFcgBYRMUa5feUUVDH6n11BKkGj3Sgoxa5A71sFOLyAl?=
 =?us-ascii?Q?PnK/gW6jrQHYg3UVgpTBx0mDwM0BX1FIYMuJRWc4RO0vBd+ObCyRfNdCuUp1?=
 =?us-ascii?Q?4jOBRCGafZf1/iWS6ih7xRa2V9tkri//lEjPy1azJZNfcW5l3XD2AROAjywz?=
 =?us-ascii?Q?PO/wJWxFg7V176Do9nOMKdMGGIi3WNz0r9jTiiJSsbvSExOG3HOA+mPLYIJj?=
 =?us-ascii?Q?EnSeOSl7BHpT84OxGJA44RsJEdkMRZXeqNfi/v9WakvTHRL1oSJeA5OEqhba?=
 =?us-ascii?Q?ukTdlEIaK92sLyTYsLY4/xh3bAIzuXTQl6YtoKYYinyEw80FkKeK5EA/UfNX?=
 =?us-ascii?Q?dSPW7elZrgsSDJb97Dt+lseARnL3OTlPtOJFaWUUfuMmiebuOjXT+/17S5fn?=
 =?us-ascii?Q?ulEY8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jp4d2xEPYKdIvuXat8uQoPZNeTXgIV8XBBxttdlf3e+uFDZ+AXvZR9tvLrU5CVSRp0YnXmJjY5EqgUMnSG++3McuYC0wul4y7D2gIQsTNAk3tG5mAPE6Dd/gQkWCsRV1opll/FWjnxWEkGXskJs4RXCNeX5mbpOsU3GkS/Y3Zsvj+VXiO8iY8reWMlWqnatPryNfRcwZfOLSyqajmJw5dwqIOpSetHSkEvaRlW/awvCK+XEaM1z/Dvh/q+rsBuTldUCQkv2nJcoud6WNjkGS3xu20LTEWhZun1QlHPJULWogGPexE1VJA8E45jqZqULTq9EtF/sO3aG8bjY7Ev1y0HLqpQf/rS3n4aarUf0nY7toylZYJmQesFWIEyBKhvIIGYEh5RDZ657QBXyUKwXTXcnQ1ZnPHzj1SrLqhfeKpux2cyc9EACR2wjMsTPMXDqa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:29.7421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1379893f-f6c8-4080-f3d5-08de6797ba62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 72a78fc5c827..4dc8f0095713 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1026,26 +1026,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0

