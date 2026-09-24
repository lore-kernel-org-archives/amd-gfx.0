Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D991C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A0210F73D;
	Thu, 24 Sep 2026 18:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xntf4dpN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BA610F734
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzcbHTa9QLicTynYrfm5o40SJsjw8MnMNaGzbg8xDHbY+NCrpOrbxTV+CdUe9P08EH273vggt0kpDn5yPGgnAj3grMo3HYgTr8PWJJmVQD6yvWODGNHGNEtqA3f91w90XZDW7EDLIpdZ0Zg0fy1TuswJ9A+l2QqWYDWJZkSZXDpXPsEkkocoCEAZjMnwJilwWLxss+jElZv7DnrR7ixYBzJz1GtoxkfalbSyjbNwWik6hY3yjUTJiid4t08+Zzazj+bxIK++3LK7L2vKfqZFvEWWHmpxr3XosVpFbcIvkaamjjr+zbvwPdmLm1wSLGSQAaRaA1PJs00fBfQ8ZRRYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aKpOfIFyqlTlSlaVncRUagyd37k1Bxg9mhP8aDd6DE=;
 b=bxmITOUCyowqpeMUlMSaT53lSHVX05xYoaNwuxp93xtTjCV+JpNEIkfmLp4edBarjr0boBohSjA1pnJPWXeIpfNxgkfKq5VqtA7EhFRKEgAIpterCPmF3XI2I7RYz3PSZHwvKg1Wrv4L++7HTzd36GHeC7pFu58MniGzHmjNgkWRkIbczEDzHvZala4EX5sZVKuge52+KA9xSAZcVLoa4m3P5P7DUVl8usYQ9Fq4LBhYsMY92BraDENdaXWyIC/NBxFkvpjoZPOiS7i/TiP3CYTdsD5MJWZhmI0WmSF+4tdcy1raekAEZqbu5FVInRoKNWbdMlJFXanRtb8vNPSEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aKpOfIFyqlTlSlaVncRUagyd37k1Bxg9mhP8aDd6DE=;
 b=xntf4dpNNfWAu4hCzxo+iPHvMCCN4lCxUia2JKqFm6NPE+SzzvpXGtt0nRsGmUCOE5zicUWPdj4QOWHcP4u3yVf7qnJ9jGu+eF7BEUvVxU5W4mAs9yNcYaga8YpBGJni5lcrGTRuAzwqNYTZOpL5qspB27uBtEYBIzZ5efW1qEw=
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:53 +0000
Received: from SJ1PEPF000037B5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::52) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B5.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:52 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:26 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Subject: [PATCH 34/34] drm/amd/display: Promote DC to 3.2.400
Date: Thu, 24 Sep 2026 14:45:47 -0400
Message-ID: <20260924184824.596894-35-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B5:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c43d1ce-fb3e-4178-f820-08df1a6c3315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|11063799006|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5G+sNJuwj9na661jTPxn/oP/XuQ1r5fV+SGqVYH+lBpG0DY5eBehwCG8fV4vyMqf7bYWr7S4uUM9+KedZ1q9oOSs1o1Jrnc4QEWei6W+66z0h5dvPDhX+HoXTN3UaWLlFCYu1t3oUFzHBRuyFMjcv2zHIW7tfdRkdfo273gTqQ/EMI/PJu9eDrG+59zDGkKc+l6r+6pwgdBqdv8ElclKGjyW4KRkGce5GzcHqro/NmJeMmpA1gAz5tFAhge5hROxtgaXh6L/XjrAJRAOOtJMFOv6rCmM3ujBKislFQLRvX+6OCBy5RZXbH12fNjw+gwY7GbV/dE/jvJxBpXwe3tqnTHbAijmsWreZ6GQtgJxtDzquf09hoNU+zKSVgnyUbhcDcZ2MxfRqWOvG4FHpd85Jjw9Sop8Peb8F/3CM0OpbJu8a53Ll7TrxWBNvIzDTMkq4evWToiU6igHiFnwERxMoBG48NjKE8mbZGO8c539Eb0d99vro7cRhdfd27mDVO7M6X2p/fLZh1/eXn/Z4GF6QGUMGzPYJjv95pGvT0FHrk3p1pHMRIVKwLZY4LpZxGCmZd0ZPFQiqIqKHOfGe64wHA0R9QvOR90f55E9Pu8g677yImk2i+X3RsEvZBW5uwcZHrxo9fcLcmJVlXzP0mR0HYjvZEISuIsU34WBT8XrbrX51S6Wox2YdMlSMtvVvMULMBBhYn1aGjTlkkXARViA8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bTPrumT3OniSg4+IeYhjkksidjtjGZgmU4i+YITQgUaXpFeKpz7xLwpVMnobNXbVI5ceZzmdQv3THs8ceJxffF88l13D1NWCiwqkg5MM3CfVxAL0BarLOCf5LP7pZnlOLEPRK7VbhHddGyZViGSkaYXa/mEN2ws/UaMxvG/CxTbVKDqtJEqCbpNBHxMUAdWhX6JdthgMz5Rkr3E7VffzxBxn9cFqOnAqQmlwuZFEVgd1PrgFNSXr2OUBkYn6KWDiC+fJpite+WDip7SMeFctjntPcb6YBn31hhk6+UE+S9xW2m18PvOsvl0HhuN/Gjj/CzIZUmAnSCb3hat42CFk5Oflq4nehSY0e55XX18VP2YwopKKH4nR1nW1qpKaTCege/NUk+CdPo/UtRVV5t8qv3HTL3/OsJvwikPeysU7uDU8kJ4RDaKAJ95HPDDM5YYg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:52.4769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c43d1ce-fb3e-4178-f820-08df1a6c3315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
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

From: Ashwin Santhosh <Ashwin.Santhosh@amd.com>

This DC patchset brings improvements in multiple areas.
- Stabilizes public lifecycle APIs, and adds DCN42/DCN60 support.
- Adds DCN60 clock overrides, DCN42 PMO/P-state support,
  QoS handling for invalid PMFW tables, urgent-watermark overrides,
  and improved self-refresh timing.
- Improve HDMI 2.1 reliability
- Enables DMUB hardware cursor offload and improves cursor/cache behavior.

Signed-off-by: Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Sunpeng Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b7c04d7cea3b..96b1c900dc97 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -68,7 +68,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.399"
+#define DC_VER "3.2.400"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.53.0

