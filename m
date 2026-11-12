Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA7606A32A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3WXyLYAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630C410E220;
	Thu, 12 Nov 2026 03:50:21 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBA410E220
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 03:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0E8KW12kspxbrm21g4xoiGy6qXq76BbHWOrXWH2krNep5oXGi7mp20ctRQ7F60ewvxtXm7cC5CoOVcUbBuZPpyCV6GngTUmDZ94oOvTL8/18OOPHf6ZyPnHFBMBsiWQtNmXez1v1xJDkSPeomYM/qO/0ODN0/0Ws+m7IMTrt0jgSJIgjaqsOIAGEyZkQH45qfA7M6wE3aVJbY9eW3V3ek5fvNwO/vdc5CPZGS9nhQVNbcYD/aXTcYJbZO/ZNYHJUmIX6FQVqX+ynujIHvAYyGU7OI9eOFhmZPuhiz2GrWeKmbbZXkMxNDaVWe7Qj9ioNcclWUR3aibchYQ72FSo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPegMUBE3zjuvDs14ZcIzAVNxW7AkDtj3mODAX8eCoI=;
 b=cDoPPH+nhn+A3AUQkZfNI35EnZx5ZdoGjQc6GmNaL/YZ0yRLNuna1LXKQr46TIlYPzE2y/M5uJBo05WO+/LDvlCdLI7BQCCfbdDH2SYf+nQRGwsXJMDLJQRDI/0/Wnj4I+Ak121jyEL156acH4WumccyDp/Fh5Wyc2+l/rgFCaRuWVgKKlvAKt0Q+WgcWC1RMyt6RQIFw2+glYbX1z/8xXrcnyhNqIFbk8B/DvMB6IaokWJwaEXk/ZcWfx2aD8qoIsQF4XmHLM8Xikl2ezCkWMCBILALnH/ojELea6AKrHYXKSNdvgo0P4x4qfSn2yPT6/XjXM7V69IVOUtGJYFirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPegMUBE3zjuvDs14ZcIzAVNxW7AkDtj3mODAX8eCoI=;
 b=3WXyLYAO9KEWS5AXEimwOkjvbVAVu8vvqApfEyFGyiYaqJjpGyuFhkbOBNI0a2v49MSU+3w0Eigdxmq9V/wcN+VJ3SML7ah3Yxc+iO2xjdeiPgv+RqFlcbbdIdeWFQolM/yq75MKOqz6ZCU018Y0FpfioQmSFrB5BYPWjag0Wts=
Received: from BN9PR03CA0787.namprd03.prod.outlook.com (2603:10b6:408:13f::12)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 03:50:07 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::82) by BN9PR03CA0787.outlook.office365.com
 (2603:10b6:408:13f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 03:50:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 03:50:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 21:50:06 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 21:50:06 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 21:50:05 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ambareesh Balaji <ambareeshbalaji@gmail.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <siqueira@igalia.com>, <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Restart DP stream if the sink doesn't
 lock onto it
Date: Thu, 12 Nov 2026 11:51:03 +0800
Message-ID: <20261112035103.3937543-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107002415.15241-1-ambareeshbalaji@gmail.com>
References: <20261107002415.15241-1-ambareeshbalaji@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 556b1303-16d6-4929-2285-08df40700ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|261009223027099003|13003099007|11063799006|261022075727099003|56012099006|5023799004|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022113327099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: lGne/Ee4wQbf3FczUpl+y5qSV7FC8xapmkPNJUHNIEkozhf0bImLs/yD3HLJXn8u3C3vpC+J7yrra1OjiI4HeE0si6WCVHesIzKXDpf6YUzveBBfgM2mSGzwJr1gyd7MbE9gI147c6Zr8Tu3onuEWucqeyZZtkr1Dk4xs3YfGOQawKR2QJNjm/Gnv7lVoL2OqyMwxRVT5gO1FJfD+9hL9eW1bIR4lNI8Kdq7nNBny54iL8Dc/fZUDA6rXJ9/GgCbYnBxAsxBzmra0JmbdNoYw0sjjMZyBzu0kmoOe70MflQX2Fcy+9WBFnE7SALcuYBixXpEbhmKxemETx489cUDUnD2K5G7CyFUKMxsbPczypQnTz2Pz3ZYqmJsg5ltAwFfEOmyzCxCIrynKpIIbg0+FJvD3dOVNG3fEEc3AaMrVE3YD5xDjphTXzb+7epL+wB1Os1M3S6+hp3PiOx1RCp4cXkzQGXNu9SmTLsSXsz4tfYlaRHX5PdD85qOf1Lukd9UzAAwMSj+Du2NKPARgrGXB7pZFUsa1jaTqhguV/YMiuKPiMvY4W1ENqyOgoTxZrVeJbsUYAgfUItXMI7nvpxhOqvORVu68Z6564IuDBtjY9aRlJyWb+oAQBYQpcQSfTvzGY8f2xppT5+aaCoc7Cpz8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(13003099007)(11063799006)(261022075727099003)(56012099006)(5023799004)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022113327099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HCuEyt7A1dFB3Ft4JDpJ9fQdBeqU+qkPJ1+n/ANhfgl7jTFpLotMwSG0ksF72uRyZyxva5vYLlS2gUFbrjdOpRYS6ivIiBfdRa0v7pzGWtanKVWyTks+wnbauPEe3kqLXuJu1SrFPsLm8Zk1B4a5yBM/cL7yiaoTc5TzW/aFzjhQkrsA/o57CKzXxphJgDzHQ0+y7V+VlzWxedhM3xdNAw+Lm/OC+jpPeWa3M/5YIahZbnBwGm2SHoXTZNNwWryqfUEbvsw1ofE8baM5ju9RX8GAtPKokduQHs/fTGbuOzWpocVyZ6YMZPFvoKT3vZF5dazT+OS4RxhTuYN4lxD0zn31i+FaSLkKuvXqknNicecykK+E7ho7RNOa/i5UymPVwe75qyLCezbsacvCyuWLa431QaevgP3wgdp+Qr/M3M9+B/v8RNGv565ouo0x4aCP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:50:07.1849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556b1303-16d6-4929-2285-08df40700ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 at 00:24, Ambareesh Balaji wrote:
> Link training succeeding does not mean that the sink has locked onto the
> video stream that follows. Some sinks, e.g. the XREAL Air 2 Pro, are not
> ready to do so for a while after HPD. If the stream starts too early they
> stay black until the stream is restarted, even though link training
> passes and lane status is fine. They report this through DPCD
> SINK_STATUS (RECEIVE_PORT_0_STATUS stays clear). With the display
> manager starting the modeset right after HPD, this happens on most
> replugs.

Hi,
Thanks for the report!

Would like to clarify this a bit that link training success does mean the
DP sink locks the main-link symbols. RECEIVE_PORT_0_STATUS
(DPCD 00205h bit 0) stands for whether the sink regenerated a video stream
from those symbols.
Besides, when HPD is pulled high by the sink, it means the DP sink is ready
for the stream.

> After a modeset on a DP SST link, poll SINK_STATUS. If the sink doesn't
> report being in sync within a second, restart the stream the same way as
> on link loss, and keep polling. The number of restarts is limited per
> connection (reset on HPD, not on HPD RX), so a sink that never reports
> sync isn't restarted forever.

Did an IRQ_HPD occur while the panel stayed black? DP uses that HPD IRQ
instead of polling. DP 1.4 section 5.1.1.2 says a sink that cannot handle
the incoming stream toggles HPD, and the source then reads SINK_STATUS.
Polling this bit skips that handshake.

> No fixed delay is added to the normal path: sinks that lock on in time
> are never touched.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6101
> Signed-off-by: Ambareesh Balaji <ambareeshbalaji@gmail.com>
> ---
> Tested on Strix Halo with an XREAL Air 2 Pro, on 7.3.1 (the patch applies
> unchanged there). Without it the glasses stay black after nearly every
> replug. With it, all 30 test replugs recovered, none needed more than
> one restart.
> 
> Captures (DPCD, ftrace, HPD/USB timing) are in the issue linked above.
> In short: HPD, link training and lane/alignment status look the same on
> good and bad attempts, and nothing in DPCD changes when the glasses become
> able to lock. Only SINK_STATUS differs afterwards. Skipping detection-time
> link training (DC_SKIP_DETECTION_LT) doesn't help.
>
> Open questions:
> - Are the 1 s timeout and the limit of 4 restarts acceptable, or would you
>   prefer different values?
> - Would you rather have this as a per-sink quirk than for all DP SST sinks?

So far, it sounds more like a sink's own problem. I would intend to solve
this as a quirk now.
Curious, whether lower timing still have this issue?

> - Is there a better place to hook this, e.g. in DMUB or the HPD path?

Thanks!

Regards,
Wayne Lin
