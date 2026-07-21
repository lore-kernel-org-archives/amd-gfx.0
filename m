Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB68DC44532
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 13:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3550710EA47;
	Tue, 21 Jul 2026 13:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRaFshP7";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B639810E330
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 13:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM035SaZ3k3SoI+Qd1ikp9qz/8k85HLofwJ01DtECHGZDPnRqvTFadAJGMLfCeortlsf54calb1lyCxH/KZ4XThwxIwHDuFUvVQkXjRp9qsYCISuBQryJSN0mV534i/unmKL1QzkK6y3AwKX9JGTvezi9yxYYqlYAxEex7HU0gbVtsHDIB+x1PEa04wqsPY0Dc3U84fnWOCbVD2hXNRa3/6G55iUiN3SpWEQmpPtQd1C2B/+Vwst4SBEQ8F8e6bOMjcEj7+i9usU2e7PsemRLoIKzoH6sILveuzpw5XnCt7wvoOdEWqJnCv9jJ7hVnT4Dl3O9LLG0EaC/XDQ5sW6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXRqfv+gt6f71OwniPIZ6P4KR6EBbvNYZ6/mtauVrxs=;
 b=sNSZQTJf+KO0ACKj5N2m5a0S1NV1NT9PCpNbLu2KYu6sj9357iQ+sBZuI8Fn9AnFkhGYNJtHN8nm4pGBtIQsgTCZgl1ZGwbeHm0eYute2NLg4SrAYTJKbZoOQdh5uFq/NubfEEnbk+yXBHX33AqFqOLWA76Pax5ivRAP6UWG8JFz+SugTy/DAFDJTJADr4nYmwlz1Wgu33VHhmwJqSYX5+bMb+as1iVH/DH14yjEHJxajyy6r3KFCvHUDAg0BDlkTPQDCiomIX5ZKvVyGEVCFEtxoJyU6AeDhlPPt5GljL0HGKQ6YV3OCeqEGRMcCM+2bnSRt51bMlPN2mq+Q9/F0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXRqfv+gt6f71OwniPIZ6P4KR6EBbvNYZ6/mtauVrxs=;
 b=MRaFshP7uW/jehGb50OZnV2bFxoYuXpOfj7mLXK8Ws0Xu3ufI6acvooca1v9xLRc2NqyneQbzjP7of1qNiNnKYpyNZ+zPrYjMRLmKKVDNyEIrlHkqy35a6doIPidwyJ2BzXM/7MsBPbpFVPEZsBD4qnOKPfIhVkI+ldsRJl+DyM=
Received: from DS7P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::22) by
 LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Tue, 21 Jul 2026 13:38:18 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::24) by DS7P220CA0025.outlook.office365.com
 (2603:10b6:8:223::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 13:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 13:38:16 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 08:38:16 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Handle invalid event type in CRIU event restore
Date: Tue, 21 Jul 2026 09:38:03 -0400
Message-ID: <20260721133803.899885-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: aa359c56-d6a7-4e77-7bb1-08dee72d521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: c5wo2gdzmwearZ5DgNZdcjxqgqEKVmW7ofmkhWphFvihNEI4CImY3poG9PrvERUoCEF2KA3HwPw/WfwjeBZCP+GrqJXH7shyeqttfbbLsY/dXjM8neZuFpgCi5W5srlOt5zkibU7H2OtsWALkgAs3+vbg3gVjadIs9spfXpZbS310rRvNniGe0kfjJUjaYDdhdpqpEX7+Tca1kQCDT+TH9Q5d4jF3PWBwu3XYKDMFFWvD5ACaF7hR7FYxutsZvBkGo1HEGtSLJdMndMy2qt2kRVZzrqJyVIPKtrGCGlsaZsiMrsGwpUuBEr7A8NxZG9KJzN3cn1e4nA+EgyHJBkT9qqcRH8ZmfIczDF28fHfoggEpdeMHj8IQPeeDmfXQHu9jx+eDL+M31R0mXEcX5gVHmoTzwForuPg/VS9p3s/ouZ/ZvICcmCC6PMsMQWJ4L9p1CQXb4tCEown5WBQ/sEPE8Y3ZHcQ7GS47TGUsPnGinmLH+BnpMecJHfodUEiJbPbnrv2WJIo7KhOo+hfuBjDIpJqfHLA26OEd/sY2tmxOkukYsG5nUG7tC+AaozhBfYV8IBZx4P/ZO0us26kIMNdb95iM03rE4DuXZr5cv5AYvii5fYcGAzvucPmqBwBHFJIA12a/C+macjTNnvqlZs/G04P7N5B1MNdn4RGrr26dymvxWjUJnWQ/u2h+ZpaxFLvFPot6EyKxZzzGksb+DXwUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xkLPw4scRO9V00F+9ufxvOy/IfbUN+kPbHBgChdBqWUCsPT88Rfolr7fYKCFhKvjtthdO28oqXTEvzTTfLYq0hgvL88Ue6MeWDYneRra5Z2znPa+JudN17vEvPR7Ea+mSSAWasZ3Wt7EG6An2j78bJFDYpcNDzanau4qNdjCc3O/51meu5ewY0fue3ppWCVpKr945FniFhCSjBpTGGvpc6fnCfYPjkCyoP2Mxo4K7xC2jWPaVUg7jD3tekhhCOTJ2N9n/YpqMhwMIrRxSVPfHLvZZK8trv4MQ4WOTHfLGQvOVUQXa9Tvxr/8TVXmT3Jqtlr6HSiTnyrBg3fXVRTCHIVfNkPABfYVpNhEd5tVOkiPP04UgB7nHp9FQzwsgb8OpfwUmDCGO61OzGkL5PD8ENWBHqy84awDnbyzQllIYGp+TZl9TFIPat+4dZTdKxLx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 13:38:16.9464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa359c56-d6a7-4e77-7bb1-08dee72d521b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

In kfd_criu_restore_event, there was no handling for
the event priv data having an invalid event type. The priv
data here is untrusted and can be invalid.

In that case, fail with EINVAL.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index f5fd78f0df7d..9e0f57cfa3bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -452,6 +452,9 @@ int kfd_criu_restore_event(struct file *devkfd,
 
 		ret = create_other_event(p, ev, &ev_priv->event_id);
 		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 	mutex_unlock(&p->event_mutex);
 
-- 
2.34.1

