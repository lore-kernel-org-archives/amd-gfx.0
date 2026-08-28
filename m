Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D1C61DC6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB96A10F2B3;
	Fri, 28 Aug 2026 07:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gEcjNcnI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8988510F2B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb6Nd6tMLHOymB6qpzfrhvE4RpFN5ggvAFabp55HLR/mf/Y4ROOBa2arD/P9+Bu8el4ELn3nlmuOAYC2oGmf0SKhywB8y/j7fYilIHNdHrggMGL21K2tHRijRXviQSP3hQfe19yeF2pymr9Cz3n9Xv3j5EWEA2g7p+7JSTvaJRnZLQU0ttHQIUDFUkWtf7tLRoju1L6uFwng/nen0c5JX4V7rDB3/xuqingvqwToNaBxooJyzgnDR1L21Uu/SdByFBOwjsP3Y4VBOwY7Csw9rtsOQod3qtl1nSNwRTiLIQokLb0hkivBm+lvrtiGj3jSGA12VFq4+ckNdTJYRGkHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YsMvDIqB0uAvKP1K2axwWUGfs+6Ak9u3nbe+nFkIc8=;
 b=nKP5TmxKSbmrjZRTPPBY6KEtxJGBAyOY0lSnsr2TJqrMd3AYRNTD24dWIC4eZz9H2wJK9geZj1LwlkwuxNW7jOy35VyRonLG0eWneAH5JNcf0y6YdIrWW/xom9ZBoSGTw0oQ3xIG7txSjXq/MGwJ1OscHOFZUEA5wXZfs9LSf4Ho18seYPAIsjRrdwMuKC8vnoj8ImcdzKiSqcnY6w7xc2c3oovHV1n4EEl36aBtLwU+7Dk2DIXUBoHU2AJCtIFesSojJ3VIJF0GUfH0V2iYLwx+4u1guE0r0cv8l4FA+oXMgZN1M+fHdGSuah4KBMUIo0ia5gDS5bcCqQz4MQrRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YsMvDIqB0uAvKP1K2axwWUGfs+6Ak9u3nbe+nFkIc8=;
 b=gEcjNcnIT6JJW1SvXI1nrNdufL/S79NEA5JYVhmIUnpOv0Y7Ump1egTxD2hYkBJbY+8NQ11/KM9RNEbLeNIiiXXhCY+kK0cryCQo72TpxLPBNQOJjBCnja/22kGMXQW3nrEKWHJQbTJiviMP1nSRNEhiuJUrTEd7LYlWgepzvg4=
Received: from BN9PR03CA0326.namprd03.prod.outlook.com (2603:10b6:408:112::31)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 28 Aug
 2026 07:47:40 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::62) by BN9PR03CA0326.outlook.office365.com
 (2603:10b6:408:112::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 07:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 07:47:40 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 02:47:38 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdkfd: mark queues as reset after a full GPU reset
Date: Fri, 28 Aug 2026 15:47:31 +0800
Message-ID: <20260828074731.258223-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260828074145.257673-1-YuanShang.Mao@amd.com>
References: <20260828074145.257673-1-YuanShang.Mao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 603fc2cc-746a-4fcc-794d-08df04d8a2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|5023799004|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oGdRZFeUuluxVUIEI1kd0+1+4Gwayoi0RbywXWh2Vezd+e6w+HKyDHKYLbDDCHzFmXzRiq9s5jPj89BuJm3S5TtpZ6kpLnHDGMOwsq1yak5X+T81SdQIjKtgcluk9YWIz2mjNbauL2RP4DfWnI6qYcWRxbnsphentspkZ3vWxeqJUrAJQw3+WY4BDLR7QHBZ9qwmFx1JD2V/6WusheJXgFyKQemxDKCOUrDI3J+6YRaRZXBo95cN4po3xXKssFpC2og7sQ9sTx51bpBRtLqtxwzX/oSlbE+8PnOqaMSxI13yAmdMLA/lgMH6JHU2gvOhlqcK8lT6mr3ckAWN4NKuO1yNW37OkFB47tR/HgyXj2+TzZhdVemsS91mGdFGLa5D/T+lE4nNinfQSU+gWDW1LgZYsN4U+IZWOqxk1o3wsSrHH5naZ9nXRl0R4jk27ysA7ixec5uU4FVeWWvLE/p1zrHpvNUPZj1bmogruoDjtsmNv5Dw+AZQ+Yb0a2a2x7kC5M/kkcDGwNluFuX9bUuTz/x2JQOsy4Hwo1bZpAe0jYYqCjDcAMVk3r5Z0NEx9w9IIRbQC/378gs3V3Y0YPaFpEXB28Jt5cbZ5ApnPlD8ZcemicV3Dd2LxnRvHaMWZwZUwJnjs9HkgD/oPdpsClDBCy2Y75aypmL+bFrjBEX8yEUcxdSx4GXear8vOmqMAGJms4qSQNhIGaS9VjMb2RkO3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(5023799004)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXZhdNoONYBW+UOnDPPPkrOMszFiROzUgLYo+gPHXfO4v8Y5tToIuKmY/rRzNLy8sfZufM/7Kihuqi//QSEta4SY0ENq+N5hlvhD1YkhJ9VCzDCWAob4RI2zh+N+bVtQ8pnjwssnHB/pMDwdYFDCHul2YAzbvK6BRyWtODw+j8icmyXC2eLvwJcZniZSQ7Go1Wrxl2U9fpGvv4Ipu0CdaezmBAVfBUhSyo5GlU43007A57AooH7wsKVIYwHBT6288y7u2ssEiOWhe+bNondCIE1n+piHp72DDsj53zWEjyB20grmQANDtM43NdPjVd3RY5h2oOyzXjoNkQt650TTvhGiRUp17kd+HhVrB0r/PZmnU93s+IFjxiep6YlT8KQhvONMesG5Vf2TRFz84fAETvAn0ygsBas+5ArQSLgsDvy4NO3Xx22RZKfde6Iv3dje
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:47:40.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603fc2cc-746a-4fcc-794d-08df04d8a2c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620
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

Hi Alex,

I agree with your suggestion - v2 drops the enable_mes check and marks
the queues on KIQ as well.

To be clear, KIQ itself does not hit this bug. On reset,
kgd2kfd_pre_reset() calls kgd2kfd_suspend(), which ends up in
evict_process_queues_cpsch(). On the KIQ path that loop has no fallible
call in it - remove_queue_mes() is behind enable_mes, and
execute_queues_cpsch() is outside the loop - so the loop always runs to
the end and every queue is left with is_evicted set and is_active clear.
Process teardown then has nothing to send.

Marking on KIQ is just to keep the state honest: after a reset the
queues are gone on both, and is_reset says that, while is_active ==
false only means "do not schedule it now".

v2 is out, please take a look when you have time.

Thanks,
YuanShang
