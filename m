Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A7C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CA510EB74;
	Tue,  8 Sep 2026 11:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJ/mNVI6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013031.outbound.protection.outlook.com
 [40.93.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FC810EB74
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSHVMGGjnv/ezSZIXe+lNTuIpHu5k/Yp88nM3PeTOa6JAK0xO/TzR3iJsU8h+IPP/aZ37HMrLTiPOGSTbPkt8qbhfu/ddeaiWXAwnX9Lq1653V4/Wau1H6T4yOt3EQZe3+pl8uj4cj31yzfqTuEl9q8X6+cLJwrnBKBH1QIhbrJeGFx2+Fp/QmqTNLQ1N7SciK7vtlaNtirxU3UvM9JG65AY8+AlEFEf0Zv7LuM1pqcWIeubP352Bqto0xF70Dk2KUt3mkXDRE9/quWvM/z1s6h33LmKOcUAFStjJ2pBMhOggipU5hpFRFXe2B6gaW8LpoUtz802IZrRoibG63w9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6dmllBln+4upfmg413Fi6jkfCp8d1d6gto+NjyCraY=;
 b=OhMXhbCj8Jo8ue4KJEpUfr54yDTaz86vpJsPnT/Z/P25qY15/T8LHxViX8Bmw0d55LvrZ3y9dbm5bTXqqfHJqIibnu8X2ieMP7lgNiO5MNci/Z584ne6iHjuvEOf8BMRupIWv2fSwkrBiRlKaRCVqrUS7RNTVmVZ5qQJi2+3XSA4I0f3hmvWhHMZfq1NoyP7JuqqkMk/iR/asX9UnqbW2oEqMiJFBsH9flaRH39kh2rD3+pssR90pEIGbty368Jse3RcvhcimWu3sGuNhDXNkGjzEf4tOiK/ZoiE6IkjrAr9Y8MoeINsprjTJeY580vvR2aMkx7Y2n/Y+V59h/tF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6dmllBln+4upfmg413Fi6jkfCp8d1d6gto+NjyCraY=;
 b=mJ/mNVI6U4V+qVS95rrYyCWqepkI/or8bpNQgtyGak5xrIDhpyyzwgx7LCrZH6KFcPGvwGiaZSlkWZLmcULS2hLYPZQ63naSHsuNpT7UBBPrkVvWJz5BgYkyAkxFwpXbQHkZezYuyQEt65KhUyK+NY6aDbUi4b2BpBBEnZxQzwg=
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:43:19 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::61) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:43:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:05 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:56 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 59/66] drm/amd/display: Return success status from
 check_mode_supported
Date: Tue, 8 Sep 2026 19:31:52 +0800
Message-ID: <20260908113338.2433445-60-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 776c4244-0f32-45ee-43db-08df0d9e6099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: F6IsLz4z78LO2T36JL08mQ8B5SS3m2YuR5a0FFe4/Pl6BYV6BA+m0iFG+sydfRm2wvYkJQz7W2ecS639VHbpcfp/uEwncOySLRGPE3OTcYlcDFxjvQh16nwkdZOBLSsXPZC9zJni6A5GWC9iodOdadRzl0Cee8e0vi5G6wwCCCKUklwQJt0vd9VbcT4vzXvrWQerHmiAmpYhw/bSSnsuJP3yuV4ISvKRWVrYPujN/37xyVjaBSmRyCXGZR8fEcpJAmBx0YrDh/KBNhdUjdBTF5LxjrwshdCsy53IK/8quPZqEskzlXUhGkM19PvVls8HGjtOoEzN0JPBwzgqxGSpEq96GyHBPZe+DEunoBgJ9HQpYb1hdmAaUPbfBzuSsadlyan2Y60frJGBD4XLS3SwUj6peUxNZ/bqj4nWmfGv8r6mLLWDO+/eWQ/yBbfgBk0lJetJNDUAgq+yHOGbE+YHgRb+ytQm7Ug0vXLDv359t80a4ILq3hg+KhI44v9llVdmoe+YOlPf/Ibyd2a3L8PFMIQJx9Ta6n6wuSyHdJxOwQN5oAYk65YocS4nSsAEbDJpKWBiqVeQ1zU81RHgEbICr2RB48quvLGCuPSSDobh48KYd0QYRLW8SqC7XqsJr2F82Wj2dhtsZX75/oEyU7ZW6aNLVZHyP6lDDSRFWRyDvJn5PaEh4GCLg2IrK5rwb3UMVn9Yr806BZyPV0Wa8uPpyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XWjN05MR0b2RMl9R74HN4p28oGNBW+3Ql+ArIK+v7BooiRiyWwtrzI3SGkZ0fwT5r+sBy4UlVyXwIEAxHNit4iB551orJ4ZzUlYBLcIyRyA5qmT4oUhD3VLK3dHBSVivQ/yhh/gKJ3jgOSQGVgC2KELvIEKGkjPYVzgGauaebXmvcGpGzUVCtgJqxhGAfb91QoGAzVDGL7eHGhKsjxJ/vzPEUobbGnXNXXSuzfuvSC6TaP6+61bsCaJbT9ISqPNk/CWz1AuJnivE0gXPa6J+p9IfHXy+pzbyNLNyreC11aECIuOQ1iV7xwyz8MNUKYiAITZJuT07AsJB1ZO+aZVrsGw8LLBRPTmztA8AFOng+8ahNWstDId4bvV9Wkk5xW8m+hyn+jjM0ZcxMNenAlU1J5Cll39liRWpQfNL8cMtk2kud6pijs366oDoAGfN6Gsv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:43:18.5926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776c4244-0f32-45ee-43db-08df0d9e6099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
dml21_top_utm_check_mode_supported must return the success status from
the mode support result otherwise the caller will believe that mode
support always returns true. This can cause issues where mode support
returns true, where mode programming returns false.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
index 73e02b10934f..77c9308bb9e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
@@ -290,7 +290,7 @@ static bool dml2_top_utm_check_mode_supported(struct dml2_check_mode_supported_i
 	DML_LOG_INFO("%s exit with %s\n", __func__, dml2_status_str(status));
 	DML_LOG_TOP_IF_EXIT();
 
-	return true;
+	return status == DML2_STATUS_OK;
 }
 
 static bool dml2_top_utm_build_mode_programming(struct dml2_build_mode_programming_in_out *in_out)
-- 
2.43.0

