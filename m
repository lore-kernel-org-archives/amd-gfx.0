Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F0ECCF9F1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B4210E808;
	Wed, 29 Oct 2025 17:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ShnCjK3s";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9842F10E21A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP2wWInmd4SxVFFTaC9OOaAFUyBaRjQpF4a/wCrxMxpU34xisYQxNVKpUkaCN4ijOrUaN36GhE8F4oebtvhqdqbT2bngFJGrbHApReUAUYN9cqF6zrTjlluz04rmbF5yCXCB8m7YJnl5P/TnT4Ny1AGv0MlYe77+YJnmQLCqYVxHpM0sQT+j7MxZgDO/JMfj8IbIMopZ3oP81oGVQC1dZYg/1n10tL4UztWk+/BcrZc0oKrifGK71qGWi5yiDnHQ3Q8C5pF/SLmw7OWjAkKI6JQ0tRTw9CCyYpthT1d4zEPQoN9fMXqz6ow7aghbeYaueXoycCU+vr0aCOCgtLd5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tz8EkzzUX1dWt8emncjrJRZ3wdBBBg3eSHrhqMJe/w=;
 b=u2CuJZkBbfzRq0ETi0cOU6wkJ7KM/s7fNJURmuDM/5ZZ499e5Uj/zhNn1tRCUlqCvs2rFZFaZu5GjsV2mAd/RGWIrUVLuzXSOZZb3xUoza1yOLuff0PVtj1Nb0jd7vdQQ4jsVD84nhH4Na9APH2xiUOxG2zpPicsSihSWra07dhHZa3Ay1V8FNcUgA1mMFB4tjWthX9J2Fzl37CLhwdGJMKlKkkSaSlhtPaUG3IiFNr2j89mAqw3a0ApYugZtXkcLYe1D6xsw4YAdwF5juszCoPiIo/rGGA5iSYAWgwY2uimO0QcQiYHwZh+KarJ5Ci6qYXiMBW6O7aZn3rziabu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tz8EkzzUX1dWt8emncjrJRZ3wdBBBg3eSHrhqMJe/w=;
 b=ShnCjK3sCc1Grvv0OMFiAFzM0SIazDLz1xy+1Hkr2EUc9vxx0Dovv4NFy2GspjOFmOCqss5yKlG6QgjPQVf3jm0eHpRPgOWxeLFN6CE5Yi3F6ZTgPlsknlLmmxT3cdecEb+O6K33R8K3gGW7KEb0f1/qzoMQbZUIkRYusvvzdFM=
Received: from BN0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:408:142::25)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:51:57 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::db) by BN0PR08CA0027.outlook.office365.com
 (2603:10b6:408:142::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:57 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:55 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update soc15 IH client ids
Date: Wed, 29 Oct 2025 13:51:29 -0400
Message-ID: <20251029175137.2861556-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 76202f38-2575-41a0-9a8e-08de1713dacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w3sQ8+/MFBCnDDiN0xDgECm5RupNyqTFC+wvDbegj/dDLkKTcW0XUkv+V7R8?=
 =?us-ascii?Q?eydxACcqP7AM1n1tkalvzfbzBUB89LnwnPYew7XQf1uW4SZlJsErXwes1hAw?=
 =?us-ascii?Q?QQ7uG8TK/jAYB3H13RIY9phIA3w3tRK3foKdM1BfQ1l+FCMwctO0w+FUKaw0?=
 =?us-ascii?Q?H3CAL28kWpcKmeGcIjv4D79qNm341PDENmZIGEOdKKVchsxPogulOXgswvGN?=
 =?us-ascii?Q?AKtKysILQz104LTyOqan5/kgzpysLtLGgZG0qWvZGAOSV5gTxnUUX1xF9t2+?=
 =?us-ascii?Q?aM/QuIDHrLv1VyJbKsWM3unO5NRPmbNjVW3lloWHULvDoYi4jTHeS4k9EW0u?=
 =?us-ascii?Q?CMQX+usVsbck9Hkwbf9JlAutY//pt655VT5dp9n9+jjldLu6g0xYVgO/2noZ?=
 =?us-ascii?Q?8qylkuud7ubKZLl366gcaUrvBb3Nn14rFmNdbPmIFJq+77ZN0x9WO6Fh8bIZ?=
 =?us-ascii?Q?uL6tqTIsPEkHKq8Hpx+0aeH5ZPolxJZu2XLGd8tFqzhGRCoGpJSEje+Uwa3X?=
 =?us-ascii?Q?7lazwaH0OIN9BV5TfD1MnBkNFm22a5i7Sgk/Tr/4KYPZXDuxEjJ6ZrS5y7Po?=
 =?us-ascii?Q?+8QyHNXkcigwhnWJ95ox+E+lfOhPHaxolKqATeru+3t8v0RsvUM0z3ZFbBQk?=
 =?us-ascii?Q?RLYHnQf0WUPJW/UdULKCQv0/olJzPytVKLS7gtJzHsIpueNh0gaoCIlLm4wu?=
 =?us-ascii?Q?+uLL3CK5dG7gtXxEa4dC5iD6haSphOeW3LCYYcHZznSnwnJng/nc5Kr+fBeE?=
 =?us-ascii?Q?mj7y3muQb+idW/XwE41rtzHOVYqccoCQdhLu/9EcZrEfA03V+BEEsDcB0jLf?=
 =?us-ascii?Q?fPHnXwuxDUKss1PJnyW64tay9FOtSWQoFHxHp4VVYsA235y54oSq3oke8j5J?=
 =?us-ascii?Q?xN3vG4HlOAltWry0vnlS3nCPG0Fb01topWrwmQUgrpbtJFCEIuA8y2gxpTob?=
 =?us-ascii?Q?xHl+jG44pwj9oe2MHQyPX/VXwZesTsfyI0OqBqv+uQvlzi274UX7UWadPzP0?=
 =?us-ascii?Q?Y3QZs/DOQfC02M2Cz9SKFAeVsY1jdGL/EDQdMA1Guja06SUW9g3JsFm9KMMX?=
 =?us-ascii?Q?im+xg4ndPqkFUnGuRX9q5hlkdz7CvqFEStAUH0E4pbepOMIrjGV17jBtzMnA?=
 =?us-ascii?Q?lzNvTOJiP4KrZOgMAn9+xWyJXsLWd8P1zEIkTm5m/1deL11vMxkgPmiPIhIz?=
 =?us-ascii?Q?a3WlbfdsivQdGyIiBwnR1l29y2bN4Pdyot3nRYeING+80BFp9pAKD6XVkdkG?=
 =?us-ascii?Q?xcK+gRqWbxXm07kcx0ofQNuOXZm19c9+kp1n87T62z23byzqGZq063zz97UR?=
 =?us-ascii?Q?pw1qVVb0wEpWfQxQs2Icn7OG88a+ehj20jCg2FG8RZBvc9D1JxMx/G7BoWQW?=
 =?us-ascii?Q?7bjeByQmHHcA4JuKEylcXRFPnWNTnMlp0tDkwXEiNl4Mg/ILqmE6VV+JbW40?=
 =?us-ascii?Q?zgT6rj+tqsMcD+sWk2ZnYZMAQCm3GKj53KWq9psEePT5EAvw7w4nYADiFiie?=
 =?us-ascii?Q?WTWkpvA7UaS3zLgXi+MDY561CnlqADPMRHpheZ62/zUhJXlUmCFar8bcS579?=
 =?us-ascii?Q?J6j78ZaXrKSohGme5Js=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:57.5609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76202f38-2575-41a0-9a8e-08de1713dacf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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

Add client id for UTCL2.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
index e1948613cc1b7..d249b8407259f 100644
--- a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
+++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
@@ -103,6 +103,7 @@ enum soc21_ih_clientid {
 	SOC21_IH_CLIENTID_VPE		= 0x18,
 	SOC21_IH_CLIENTID_PWR		= 0x19,
 	SOC21_IH_CLIENTID_LSDMA		= 0x1a,
+	SOC21_IH_CLIENTID_UTCL2		= 0x1b,
 	SOC21_IH_CLIENTID_MP0		= 0x1e,
 	SOC21_IH_CLIENTID_MP1		= 0x1f,
 	SOC21_IH_CLIENTID_MAX,
-- 
2.51.0

