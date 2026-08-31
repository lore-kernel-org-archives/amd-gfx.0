Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA6C79F80
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A462B10EA93;
	Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMXehs6Y";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBC310EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJKGTdCMhZvGEKQJO4XXRATxKF1U4Nsx+sOBkltO226cEvfZndfCizL+uz0DkPuHODcGanSueIFys6pznooVDipBFSSe7+WKhStUrL5TqV0e2oCIMFB8BXC3Sh4D2/1FEmmBWq3WZDEbEEQREEM1Qu9dP2sLoKT7YNv67SRJQ/OV0SubsohzDHad2J/R2GKCsmv4n9js2dYy7AFhzSrVS9UoTJvSLbLur1/j9qnfaz8GmXHSJbbjyMHfSRud+WUHs9SP82bD9kN2z+fBvg/m5q6dp8/r1RgQQes0otEjJvZUi1kTHUoVUc5Fffi4owgrRf50qGLXVLihN9Np1W1S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXJ/lyudMdwYK5Irzq5jSHUxskFyVFW9h5n3v8izJ8A=;
 b=FLb99wSdaQzP3ElkI7ssIoiOzrTxOJLD4UnFIIXa5RItk1X8+j/QCrAJAzVXmaZgYObEn3P9qxKbMhMyqtt7Ah7CfCcie2bfQFAgIOVoh4AjC9VQLKkqwVGjQTDpgK51NuA5WcdvcOYGooogsZ8G0SC6DvielsKoj4NP8QPAeNddU2G2Lq8QM1Ii9cJI4wMvB5UouUrjlcHBXZKIAeE+0XSi9jpq4HjsjJJPt9WbxYv/G/1xSVRBYCNarP9LZoBDN/N/q3Mzky8xtH+ui3k+PkbpsZoSuvPlvpPbbhoqkyxi7fk2Hnr6r4WzOPTh/HvcelGgCU2ARMt9B3crWzE0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXJ/lyudMdwYK5Irzq5jSHUxskFyVFW9h5n3v8izJ8A=;
 b=EMXehs6YpAU6Lle4F3AyTtbY3xqbwTvAOLCGRCL0ES72jsI8N7hxOlrjdPknQVngsY2m81CqFDLjcU2xh9AB/FRSvpGJeWSIBWCp/yTDJfdjiM6crhGrO6J3coW11LMSpriBUw2Hyf/UawZa91i/DULui3m53thzCpO0XL1IFxg=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:48 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::a3) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 46/95] drm/amdgpu: Add ualink handle to BOs
Date: Mon, 31 Aug 2026 14:27:05 -0400
Message-ID: <20260831182754.1089811-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a18f60-e82f-4b4a-d7ef-08df078db256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5zgc4VypVFYOpuEph1n1th2dLl40Il1z49o2+bWexAa0uitUymH6iA8pfou6qPsPvnKVB3O3v+2QbNbu4vauyY/pAaVNieU85Y7k9IgSKN4ObppTaREjUQhyF8eBM2Ms90H/gzZWmYyNKxLuDGQUjYF7fKU1HQERoau945xn29SBRiJL+qSszqu6TkIFJLuhtexUWJxC72g6k44b2PKLpe5BSYuDreJjSCUHCZDsqoJskkrIrdWtSqIWRHLjI8skVZbnnUd7zph7AgSJsZl89Wa8ChUHVt1+B0XLS3gjjhxxg+eFCPz2ZcAiahmxhF5jwGBDZYS/Q/ptc26WNw4n9Ar9o2LrZQd+rUt+IiG9eeyfl4lBvou+zPKsi6c1csaI5Owc8ewBE8O3GNQceXpp9QfhbQE5Gj8PthKCchnyIYKZ3w/NIuNVTL6Zhn4F+ngttViF7KtQ5EzjI0a9hUFpUXUDbBgN9a2dFlw7Rep6vaQsfppw5z9l1h9rc+JJfyFn1MoLpP8k2cTMBS3fd+3/7UuqzV7ZNf9DU5YqZ6qoH1cbOlGxm124QyeEQIhUFXVVrAubTTKM9OsuKqVntGG+kVd86LxuKRgCpKQYRnCTRB/KShSgvqPA0oaCoxooTdptEYOGfgVuxFDF9sAJDOFgh5Vlq4wEhijwkKhxcuArKnqoGVKxQEl3zCeBeOITc7/lnGqSIscB35BaYvAVgk1SdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i8OMb5LnOt/qlguecmn5B5Lv7lWZ2BX/mwSFiYmxK+FkdqT3ge16BI41mgbrI1nFm2JQT42DG4vroRQnNXAkzSnhW/v7YoQI340igRUOZ09hUtEHGXfGGMs2WJhCS6gJzwZlYixSUmLEqd+x10mneS1ig+OkmdT9qqvUMwYqPPH57vNJlV0/kHikLoaZZXHsXeJrdH+1eU2qsxLQDtkqznZxVT4aeyQdf/G6aX72iuWv2ywR2YGgLri5YsyYTdBCMREy8w2v2e2yieHxku4k4ddo9onK/ft9IN6HGKpirv2RMnrMZZ0N/FCtzlOmgOLQi8FOQ5HYGZgu6pWoqRyD27gsIAqSdT6yW+175sazAPgWPlpRzidU6aJNKu3J9y6WXENm4UAeaWli3KShIh0XMD9WzYvsLgxc7NJiHAZY5prqx/aIvBU14lQKR8BqvGh+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:47.3260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a18f60-e82f-4b4a-d7ef-08df078db256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a ualink handle to the amdgpu_bo struct. The ualink
handle is a 128-bit unique identifier associated with a
BO and is shared across the network to facilitate NPA based
memory sharing across GPUs in a rack scale setup.
We are only storing the low 64 bits of that handle in the BO
struct as that is gauranteed to be unique.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index b41767c7913ac..2e6a8e6f577a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -125,6 +125,9 @@ struct amdgpu_bo {
 	 * for memory accounting.
 	 */
 	int8_t				xcp_id;
+
+	/* UALink Handle low 64 bits*/
+	u64				ualink_handle_lo;
 };
 
 struct amdgpu_bo_user {
-- 
2.55.0

