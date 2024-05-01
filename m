Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17C7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D741130C8;
	Wed,  1 May 2024 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cTv9GnGl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9791130C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+UQGi7OqdUyNHAFAoXc/2ITpIbWItfSYbncCD1evD/n//ag9PpJJZa1p0nwDpzb7P5oivRi8NW8IkrLjRy3PF9Wo8tBiGgfDg7/UrWq/BmQ4v49ChkbThq3n2TuIYeLgfBL6X5XGoctYPtAxUbIzInQ1apTUzzf+xyEmSlVDO+QJizggupGch7QrNSC3F6A/QLYXcNp+S4GGFcekPVdlCcE6ss+2MYWVnq7NPNvJ2sVixw2rSwhSRVef5iVz6m48ldft+Bh3vS8uNCtsV/6O8RFb2537Mlc5ePUja6i3zfuGFgsqasLdTkhzUqryFADZNALb7zKfsJLyE2zv3GMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5xic1pwKBFNL2tieR6NYo5Xlbz/TJ5qTFxTtA0b3Tg=;
 b=G0cg6zY2hM4igJAvpZxuE6fANWWasfuCD7olVkOEKhTYt+D0b7YaLIrbJGEV2xxdH38GQQGeQQJZyBPO3OU+Ceo7Fu8hemcAOR3OppoV37SO1DTB+bCuM7tnCWQ/iXg2TrC4KFXXG01BIpDoLSzsn5EYyU2GU1wBhvAd1F6kK0J2Re43ww45WeAcMMfwrANNATFCDDI7AAWJv4l12hcpxSkKxEADpPkJKanIPkzFb/4FGHkVlUJrJM9dqTv8u5YJ4LyqdakJhEvxBDN6ZaYup+9YpAE3uOW26IetH9AreOLSO8FYyx72FIgVrsvTiwKSnYLLCECkFAIx9qONLbTMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5xic1pwKBFNL2tieR6NYo5Xlbz/TJ5qTFxTtA0b3Tg=;
 b=cTv9GnGlWZKNXiboxqlsWdCkaXGebFiLLQmnaWCSJr8Iw1R+xjflqXGko6qx9qKaHsvWT03wnvUpmTqgJGmFGul/2yXKfKpWZjMfOK/yAtBDdHiJiBp1RiIlAzSdHz6LIcmwJJwNIEqpHQA664JfdCOPBf/FbntchRtLZjCzlXE=
Received: from SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) by DS7PR12MB9041.namprd12.prod.outlook.com
 (2603:10b6:8:ea::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:19:46 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::ab) by SN6PR2101CA0013.outlook.office365.com
 (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Wed, 1 May 2024 07:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:19:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:45 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:42 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 27/45] drm/amd/display: Reset input mode for DIG on encoder
 reset
Date: Wed, 1 May 2024 15:16:33 +0800
Message-ID: <20240501071651.3541919-28-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f828a86-e1be-4b84-d2e9-08dc69af1477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WCQvFJ7x5M1TOd13HAdCnDNwIuZv3F2TphYIyhd80gQHrMlWO+XT6irYAv11?=
 =?us-ascii?Q?oBLoRougmm56tEhsDFjcMNDwftaZTQWIiJBkNi3T8/lrv0jwW0COPIDmbMMv?=
 =?us-ascii?Q?gczaXgEEDMXd8iZPmjMOFTDuNzrxv6cAna3K1O6LYIzXq6SDZ7kBgl+AB41Q?=
 =?us-ascii?Q?RZdhEbsM0v876u6ETUDQxOD/JhpWMVdB2PJpwZnDyajDyuZ48NifQtWNuynU?=
 =?us-ascii?Q?5RMpum112shHk2bZQ9SWBk407FtZwStoPYZkymlkw6nUUg1cM9kqB4Tv4LoQ?=
 =?us-ascii?Q?pTKF9x3VxEZLszuP6+fmpLDGG4NoQJwZUKVqLuyfAMfRkyB0e/7+WEGvTXOx?=
 =?us-ascii?Q?XwTSjSYiZykTMP4fTjeCwX9yTwwKuL5YLtrZ6BHOmazZ2rQOIUFGiHyQQDPG?=
 =?us-ascii?Q?y6LRnAGF/3SL5GPYf2XPx/QaQ2wUgcmVlTX7HbxsrAusFnsf+spZ4Jie2Ez2?=
 =?us-ascii?Q?KZjFlsFmm/TKl1Xkratz6NSRYf+eUg8iePPI6PUZSgrThp9JF35LETWJ3DsB?=
 =?us-ascii?Q?nqFw6a76GKe0d4itAS8JS1w5/8mML86u1N+ZlJJ1UshdrH4tz7VJVq/cSin5?=
 =?us-ascii?Q?zZcPbCrQx+zYeZyvGMTQuijknJwJrzNgi8Z6lU78QjNf0bcxJfHerDVcu0zb?=
 =?us-ascii?Q?ouip8XnvZOLSOPcevmLcRE4Tq09li/X5jDNq/+USSkJ587i1OlhXqngM+nR5?=
 =?us-ascii?Q?P0yYD9zXjVALrz+fuLtoxZf/ZnClFdbCcB9FqFdX5dWMvTKf+1hzOGwhuFmA?=
 =?us-ascii?Q?YL1u2T5a12j/w4wEoareDSEnlCPPRvzYAoxv9sT1oyflD5c36GKBqTmIIoXP?=
 =?us-ascii?Q?VP4AHNUWjYt+f5/bHAAZhoiWYUq6+566G/eFDD15QQDUZ4+Jc/Q2aNZG+R3A?=
 =?us-ascii?Q?pLn6We14pGAyY73WFTCHpnMB4ZsoPCzn8czv75pALl8q2ZsxVNFUZilp8/dJ?=
 =?us-ascii?Q?iGoDHQgyOwIjvAfyWxSot/IhtXAYj+Hs3KhDw2wK4GC3eD7OMt05tw4uvb0d?=
 =?us-ascii?Q?nkoIA4vJwZ5u2PXRlivWrY1hp2k3FXbxe42VFkbScFAgEtbVyAg55SrY1Miw?=
 =?us-ascii?Q?Z5eE7W4bu/+CL1M3CUfEWyYZGsgB4AIgMrRHOdMtp0WKE0C10i29Ct55oI64?=
 =?us-ascii?Q?6uLw/pvXb1yTx0GOMgcrPYN+NMOJxihpVPQXNDan+Mc+0S0GNFXv4R3c1IMG?=
 =?us-ascii?Q?vkzPM6BRbH1n81+lJZRX3Z8eo+XkaECc9arxojmE8hqQ6haGSlOP5F3tQ+Eu?=
 =?us-ascii?Q?vi43uT7u1W4w2eSpTpKvTdh8QCmnEHMYvbLTRmr3Sed2XQg0vgxqTk17fcK3?=
 =?us-ascii?Q?6d3WDketkJ84/iI3UpB+A1Yny9DTi8phJ7BjQIHFcdgceagsXdgrDDri4fnE?=
 =?us-ascii?Q?JWU94p+07XzIRJtBrF8TOFg5Q+6t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:46.2733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f828a86-e1be-4b84-d2e9-08dc69af1477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
Make enable and disable sequences symmetric.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 16412094c612..afe4614e0087 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -63,6 +63,8 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 
 	if (stream_enc && stream_enc->funcs->disable_fifo)
 		stream_enc->funcs->disable_fifo(stream_enc);
+	if (stream_enc->funcs->set_input_mode)
+		stream_enc->funcs->set_input_mode(stream_enc, 0);
 
 	link_enc->funcs->connect_dig_be_to_fe(
 			link_enc,
-- 
2.34.1

