Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFE7FD45F9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 00:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998E910E847;
	Thu, 26 Feb 2026 00:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lkATbq8G";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6015F10E847
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 00:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo4pUwzUV/eDUvnMLwwOIJR0eA1slg/h0pErEHuOnAnzjpQXmiNjowN+aVqXTa14UCXGNXcTsj5Yb5+Qj/LwDAoPiw2JMPyhlIVrJogzct/aU+dWDJtx54HL01q1bLJ/hzhBplvFSQ6w3qph/LqRaiQyVO4bE2aeh7iJgWLpsOeU0gUcrYLvLL9KMGfSmxrDZpU/IfzYdcqyaYzS1yUNtlAFohdrYluvCd7U531ly+RZAxkUHbbLnNnWS5IoQ50UuIeawAnNdWa39m/nHwDZiTHD3t3latjwMiwuE5htmVHfhNNnpAVIV/2QYH22f+wVGKYfsU1vCdgoFzX0V1x5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9GZd56UFJjMpU78roITd0HDKeB3/nyhX3hz2QNd8Ik=;
 b=fUh4afm1O4/4bUwoRag/+2UYHmUL5QSRetidYBzA/ICQsyTktRGqa5SW5b6NT1E3wxG59O914nKE1L7SaD9phpZtaXZv+ivKBtJuPcV48vO9ClnqTQOejqkHtxb7hNiRIDIhtSRGW0QRi4PKHC0V10QjNHBZJzJnw8xi+kDQB24w54UjNUT9+kYF23NGaWEJQmEyrRQW+tYIh+kcI+DrqBFnlCLX6Odg5Yi5O7kuV9mpEuj/YOyBmgD+XTbb3aLwEoq9SH7DInnAgqH75lOVgnrQX/Ect/MaJAop2NfLHZiURGLo2E7dHndJpCaZmpEPHrXB6DqifPBZo5uNIEyKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9GZd56UFJjMpU78roITd0HDKeB3/nyhX3hz2QNd8Ik=;
 b=lkATbq8GXx31wO/MetUqgBLOxtHojWl8/TbAI8HIvQHfnZoS/40XCf15Xi14ZOD+yXBPPp1MamtZSXJTGOXfReOkPolYs51KuHAarqaj/Gzk5LIErdYdkYeuMK0evV0eyoa88UeX+diiIPG92mYvh7aEoKPJT4Uz1RxEeVWv8DM=
Received: from PH8P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::16)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 00:03:20 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::7a) by PH8P220CA0022.outlook.office365.com
 (2603:10b6:510:345::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 00:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:03:19 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:03:17 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 8/8] drm/amd/display: Promote DC to 3.2.372
Date: Wed, 25 Feb 2026 16:57:47 -0700
Message-ID: <20260226000048.68030-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 850c1acc-a0ff-430f-c428-08de74ca72d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: MzP137N7karSXe7hpZXK4nJSFRzwkEPesuYC+4nV0KPcZ7LbMUyARD1eDiSuWrB++gG8rfzFp+kruJNEdyoei1ygDKGasShuIBBnQY7z0jjEII0E739CP6QGEeMDwVXTg7+AJBMWitAEMWvXe1ZZ7KH+fFxi9Axy1GYuHaSLHGg7Rw9ZUxix5SMEPN3VuFa2Le2p5SyHFfu2FU9h4afouCyMrrxCcJT/hnjp0t25u4AtdDpOYM1/c9nHJVNVkdazo5Sysf4ogVz1bCKDo+W2w8ljPXI/R5yxpxr62zEyfddNf2AQ/7xWDrkdkE9yguuRN+BNIL9gMmQywhmGMBfm7RBZgTXTx6MK2Dr+8OIKDgcvR8qfUiiCmkvrLqjvw+kaelqFWsiJgosNHLsRzhw1A67qSAINpbR7t+zDhyhCLl6G8MEGSgE9OXNdXYb4G5e9JNyrIOtFZ2DkkxqndXXFUp5gbyYjq3rAguhis7OY5K6MH5nyRdp+80diKcGMPE57UjGAHFx717dw6TxV3Z9m0NitPSsHMcG7rDUue6yBcN2Zg3tamicTonO8O1rRXn+xPaUBCt1fDTJr0pSczA4Fh6bl98+Kp8Em6MKM8RZE0kCuyftCNvqDHnMxEGgoCU4FQayE63HkuxASRGEinKyNorVhHSaVzOTAAcV5Yi9Um7dSwawPRwmFhvM4n+8w6I2Qk21vUgy7Ejjr8Fz8Cv0RWzgeBcQDkUu3KmJI1BfP7vi3PS6UEZ9H9mhkdURdnbRud9zbCmIvrNN320RECO9PcuD0ml0FWBxjjd4dDsPCM2tVOYfXFzEczwpk8GjQ+2WAslXoerXzxmKqCgY8/dZNhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1K0ufTpLXCV9AcqTEj2lKOpI6nhgIhA6cm4q+hHxbzs3YcNlx+PYrGuvM2ikJOuPbf7zkWm1/Pn58cv3eJHjq7pRYz/n+JFGHyA2MHCzzYHQr1rkXj1bC4Bbd6hQR86BfeWgXoNDJWP+hJE6KHSEiK0G9ZP+zD14NYjIRrwXVjf5T0Gi+F8IJ97bwqNQrfw9n8xQ4VVvso/jvKt83weLeiz2jT7yCqgMQinTBtqi98XRsd6Zfcb1sCYXfUKGNQF3pTjdaltZC2JqHiuQsswD+VoQzzPU302xxHzm7jbx/goD52EodXHy7AmralTZFt6Sei9fYzMSRViKR9G8vXv2Fe+oAIWgV3XivRnt9Lhojv+cfHJH7RQZBo5ItTq/v0WvHt+JVCGB+42HcKJt1DLAtFhkzCHhoezupGOtBBu+QQtgbddhDO7+7Y/bHdkCCG4O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:03:19.1473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850c1acc-a0ff-430f-c428-08de74ca72d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the follwing updates:

- Prevent integer overflow when mhz to khz
- Remove always-false branches
- Remove redundant initializers
- Silence unused variable warning
- Initialize replay_state to PR_STATE_INVALID
- Fallback to boot snapshot for dispclk
- Skip cursor cache reset if hubp powergating is disabled

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 32fcbedd82d4..4bdb7bb47c75 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.371"
+#define DC_VER "3.2.372"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

