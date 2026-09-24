Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF5BC98310
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA0210F32A;
	Thu, 24 Sep 2026 07:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PO4xDCfG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F7510F32A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwqBRieeaPsg+W/olTq+eZK38pgrSovjkcw27lqwJwBxcSXDhRIzzLbIbFFw3I/UMTzGmSw+/M6PPy2Hno0rKn0AQwoJ8A5ihCrSXb5ZPmQpV7Cs2WpFDh+VlhqyDQ4dLmS0JbGg9n49mEa4wLLEzvZ9YiJgY0yVLiUDeP3FvgX30TsUB4JANSV85m10FHNE+U+tl8CqVfT0aaDa8ztf5ZDdQz9AMRVCwKCUoX7yxr9tfDThv0jovlajFn8kKY/uQ8vtHcVI5QrE2dVUcIDvYMeQlWuPUcBierwAKO3EU7MT5nyCK069MF5k5IeBWf/mPF86fQcqvJ0Rz+i7SbUoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBpwLgdX7cAjES51GklId23bwbcd5ZPsdtPcmuqJJiE=;
 b=yNp6mChNFWJ6nADGmWjyVFBok5POuJxbHU6CsL8C5wcoLfASl/KPQvWnPuiY1wQIbbSQ1xFvAiDflDC3tdRqc0I4+D/QXe9K4SDwbxZrXt6LeysZ8zSqmdhbPEMeFpPnwOg3hj1Za954/bxVz1bdFQZID/RV4Ij+scRsGCLpRrOFVqngwQ5naUkxxRDwvXh8f5Ic3mJtAZatwGGT9lGS0qd4xwJm63ZA7QyldQFSd/nSswPUZxsEU4E69FsvBM/slmWlPj84+SCkPnX4ebambYO27/jEuHbOdud3FozHOwWzHHTVoJM7IBOVXFSjsBiXYZTF5X5sNgZgFjMVg/TclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBpwLgdX7cAjES51GklId23bwbcd5ZPsdtPcmuqJJiE=;
 b=PO4xDCfGwEhnswJwyBNJn9Cdl1HSiDaqXg5hQTel7c/6UORwsynHl1TIihL21jLHCeCv47YzRZO8X53Mjoz9xFofPB+rxgq83mitDuKmVb7qaPCvfVWTwNL+R1FvX7tWxVF9Q5jMcxVS7qE8rVGL0LHxDcR5lpAQB5jRpCqNDgQ=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:01:49 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::31) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 07:01:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 07:01:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:48 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 24 Sep 2026 02:01:47 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: skip MGCG programming on a VF for gfx v12_1
Date: Thu, 24 Sep 2026 15:01:41 +0800
Message-ID: <20260924070141.2150726-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f00939-f900-4340-9533-08df1a09b46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: RlIkwZthyp4OTRKq/LErBnNF/aw17XGuS68aikvhmc22ZBHuL5ARRTDHdgsyQqNQ8bfMkH9CRcPkKD+3m6hTGZn20rltUOorWQN5yhsCbGOcLahMLzSv+0jXtGervLNjB1PhZ+s3YSwYb0pxcPFzA9hgFa54c3y8AxVNo3Vk+nBc+eXdS9/b8yinZ+FUv8s7qDEQr6/IjT2wSr3N1B/78an5uYPQGgvKv0hMjkx14Ipb6oJ+JqZXI/kXeHRKmi0er9YW/gCfTY6vbttkvWxIEJC+qnlrgkFN4HF82CTWjrO8dysu/IRvcLY2BRwYyXCZgPD137+4wD38alXfVG2mFEEwS0A+T3VovXddpR/hASDObpnu1COgw7//ePXQWuM9IuClDmA3Chj8yhc2zK6Wr4f4WwbU5MxO9L7Mwb4TnuTMF1uo2TYFaRkVjbp9Fa6CnKN5JQtIJEccU/sqzXUBTbg2iW8xiSkb+84ZRAlZOVbUqroaPKbjHz/npUh9dfGh782guksuO4qS7ZfyQ5B4/fDv65jqJu8TXxAIUlU86W44j3wqJcJ/eJO/ai6UnFF+jQBJSkV02kOvdmffOuiuH27JUezJo3LEv8rTO2hLC/3taRMa+C1PgT39Z/jazRUQpS6rUhJ2wctrcYFjo8HI8asyGrefNrFOEbW5aMsD5vM3Xjp5vsUwTJIt2nlm38DBxMxBc5A5f++37ubtucmIMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lw1wBgcsW1VS3Cea5lhKZYvrMi77Vi+hWmLVkJxQK71sXTpPTSgtF2Zi2m5cB6K7xnvPeZO/4ytWlv1dSxzt4gzuNi5OUiJDa0bmDQRj+0KlCiwbPmxjhX+Mp1903yvvxrnJi311f+qGbMl3em3UG1yUv44V/Zd0JoM84NJKGDG6R/rr/6VNlcLlQf8O18ykEd3YqswaD1TP6VWKomUNjP/mE3B+F4g/zwIYXxssR+KNwSDTyn4n0u8poUqVoCN1SxwDjfCu+96ziNUTlN5dnpp+MQ8qgDNbDXc97mF/kF0J8ljnbh/9GqPMSvH5OzF6hchrStkCznYz7M7DBHQvOTZSBplm+DndC5d467few1WLym6eM2MAHQsHQYuNWaroT4h9Hpp5zHDuR1HuHUDab4xIVcaShLkEInGjkDOrwdQ7eab8roiG+kiI8aiA8SW1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:01:49.3000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f00939-f900-4340-9533-08df1a09b46d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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

MGCG registers are PF-only. Skip programming them under SR-IOV.

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4f6eac30b235..c9de9216bd65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2417,8 +2417,10 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 				return r;
 		}
 
-		gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, false,
-							       xcc_id, true);
+		/* MGCG is device wide and owned by the PF */
+		if (!amdgpu_sriov_vf(adev))
+			gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, false,
+								       xcc_id, true);
 		/* GFX CGCG and LS is disabled by rlc fw */
 		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 
@@ -2440,8 +2442,9 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 			if (r)
 				return r;
 		}
-		gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, true,
-							       xcc_id, true);
+		if (!amdgpu_sriov_vf(adev))
+			gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, true,
+								       xcc_id, true);
 	}
 
 	return 0;
-- 
2.34.1

