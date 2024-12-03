Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC0E74ADF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BCF10EB7E;
	Tue,  3 Dec 2024 21:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B7RhUjLT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A7110EB7A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIrU2dwKLj7D4aZxyVUr/LDpG0qWa8xFqeo4VdU/MzGwttjAT51pRzuJScw0Vae5+kclY8J+Fjzjl4nRTqz5xF8mkohl23upD9PRhBQZultN5Ajr6M/mVoeOcqGaG97sgNf4UQmQCDVQvJrQ/n8udyyH1Z20eFbWWxExpohRwtES1Jeb7e5xR3MK391Z1G2f+uwGCAX7h96ePmx1X9QP7DIdfY194w2ENWcNU3C0s6kIa+OD5UK5HmtebG22eAj6VIgba5BUlfwiwR188aLMmNZfVhOsR0Pmjk3FPPuffDH78M7fk/NTq/t3SiTAmk6qNL1/PfEzqDh/IZ1s/V/wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxevnF0sdAjEGyyEZSWeHQfiWiiOJVom610SGxME2vw=;
 b=xMihk3DczqExGcEJhx8x6KMvziPE22VOAVL0B0vHSByrElE+ueVRTSRlNpsULe6Yq3+yntZ73jHRKUtjjujAJdoOtxi8eDzEjyQPfzaOf/WiYMoNahgBriNPWz7k5HU++oGnJ0dFepOlrekmYwSccCfO1uoK8epktCYJ/+c13YWOWL0Ay31pBNhg/To9UN0EpjPQ8siQpVS9mis30TzlkWXQO5CDeb+vSGwYzAImNx7JUdawkHTXDTdU7GhI7BjSwk6arfJ0tOAg/kmlhUDlxvsHccw8eGqa0/Ys53PzncD59gcdh8lnEFI+0oB9ANrfCD8t2J6/LA2UzWNupGsJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxevnF0sdAjEGyyEZSWeHQfiWiiOJVom610SGxME2vw=;
 b=B7RhUjLTgGvEmURBpLLNneVhDDkok0nYs/78J8pqbw3ki7ARnWKkn6Ri4D2PlVz3GDZIQKvkjBe/JgTYYa2yprYtsWv2YrWL9rI4yavXcpRTP6yIIo2KH/j+gFLxWEgsFAbab6kmAjR++0nHRJba4yGVH2sNMuCb50QD4tvi6Tg=
Received: from BN9PR03CA0334.namprd03.prod.outlook.com (2603:10b6:408:f6::9)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:51 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::ab) by BN9PR03CA0334.outlook.office365.com
 (2603:10b6:408:f6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:49 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:49 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 19/19] drm/amd/display: 3.2.313
Date: Tue, 3 Dec 2024 16:39:57 -0500
Message-ID: <20241203214120.1161810-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 516df7a4-77d6-4c0c-9dc6-08dd13e34bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Leq+tGtEnNhEsD5OeMNwcPgOnbLah3HTzQ7MG/h+KMypeuEsGUrSHb4YowpA?=
 =?us-ascii?Q?WA/NGBHNB9sQOA7xLh6fZHw71TEPVMDy39Ol0pcLs5vcYPo6GwELN6jh6IZZ?=
 =?us-ascii?Q?dRAwawdIBigtrT2u4d1cu1ObA7ZWLXkPqZpiEMPNGP8WkHiiD+qoH0Hgen6r?=
 =?us-ascii?Q?riBkj6zqhh1YqwOGqdZ3rUGoKgo7ClsjJG2ph/MfsxufNYOPQ3TXjln+cOZj?=
 =?us-ascii?Q?n19ZiDq82m5FRaO8W/fpHi9QW0NZrsqv4kEPZv/tfSYzKM8uVuYSmk1pq5O7?=
 =?us-ascii?Q?s9uQE/kR8mu4Ih8vaNzXTSFKQGrlR3fyiZk1tzuaixHyjUN+fCkMenjhSYOK?=
 =?us-ascii?Q?381W0C8FLBEP+cHynu6wg5YEUQ53BDYN1E49r98oHr0/HN7FchZqF6/S5lJp?=
 =?us-ascii?Q?JecRgJHLXT/fmZ64GEnp+7gZI+LpNgyOPYT/TgTK7wNtGajOfJQBZbrbYn+u?=
 =?us-ascii?Q?lU79Wlhc0wv2s6LcLbzNrd0nOWDWpAP7j74knz8q1901JzpTbNRLnZlxuA0A?=
 =?us-ascii?Q?tRNIOa5E0HUM7KFIp+k+Wn7LdUurYBEISY7s3qWdOjec81gf8CogCc9aEOoF?=
 =?us-ascii?Q?juUIl6uUtHQUiArTL6rAAfJ/BclHqstMvntgMnX1epZiuDHLGMMouCqiklFF?=
 =?us-ascii?Q?dKYJLBXsa/qDweu/fEBpET3PjnPU2pnG/P2/W7rgbEdvuAOaR/WoRSDX5p0R?=
 =?us-ascii?Q?Iu/XGnaBZ7cu9bY3bp4l57mKLv+kTQTsTTSOIeNDc6EveSphqbIO2W4OrZAX?=
 =?us-ascii?Q?6S7+/krKic0azbF6L8Tz5TktGImX+HRHgPQJ3K3gACAvEgyaImJk8yb3SumD?=
 =?us-ascii?Q?yjw3aADTgUzPmWoU5Ph2z7AgR/XPFGAqeyE8ZY0Ot1/mOKh2FmCXU2AXZvy4?=
 =?us-ascii?Q?TEuqgA6/08JdgWeSmjeHDszAUO3XWYJmwb3pNp9Dl8LYSz0G8izfAT1ta9Wu?=
 =?us-ascii?Q?1JEBa86yX4wn1Ss8Ls2vA3OzI4wkaJGreY+41fYSnKH+gWgYG1I0897mkqSx?=
 =?us-ascii?Q?FLe7NZ6o9/sDV6PrsmUQY0w9663lo6FAcapyTcYGmjSDNm5jPNFq7b1Ab/aL?=
 =?us-ascii?Q?s+ohtXga5D9qGqk+q8m2yvfjOYLltUs9tuXl9W8y0dPL1ddWI0oKbl2rThj7?=
 =?us-ascii?Q?SrfIfX0r+ZQaabXLP1gmB3CONK79PhHN9IHiowOmfqpSxlJDWzmkLSSYHaOJ?=
 =?us-ascii?Q?nFQ5aZr5RmX3zR0zN5WQdV5QHKGYCvvs5nznRp4npQ6BBNY67eiG9+2FN0cM?=
 =?us-ascii?Q?wrtw6PS2cMPckOMT50Pqm7RWzljPiJBr+1X8pMyzX57ci5kqxlNPvkUM4PvF?=
 =?us-ascii?Q?cSHqZ+W3bArSGE88dWhEC91Sup7jYl1N1QUf0AX6AD/38fhozaN7wmFZozvl?=
 =?us-ascii?Q?SsxKvYR2V/8bXPqp97wJoRaAgoYy11V/DtuBV16P6KsfK1Y9qmjShbSmqVQs?=
 =?us-ascii?Q?wqus+V+yjDxNUQ5eyjo19F5iJgwDib0g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:50.5927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516df7a4-77d6-4c0c-9dc6-08dd13e34bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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

From: Aric Cyr <aric.cyr@amd.com>

* Fix some regressions related to IPS2 and PSR Panel Replay
* Bug fixes in DML
* DMCUB debug improvements
* Other refactors and improvements across multiple components

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5cdb28a8191d..9cd81de4be02 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.312"
+#define DC_VER "3.2.313"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.47.1

