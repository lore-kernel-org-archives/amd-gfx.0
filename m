Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BFCCA1002
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DC210E551;
	Tue,  2 Sep 2025 00:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/C7oOJg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CF910E551
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E//o8Gi02AkO/Ht1mxLc9SkdzDZIVCfteWIqrkN/G/RQbX/VdNWoZvKwxCCYKbslEBPKyrTignpbULQLpBDYa4AM+/ktFHyKO4lSCEgD31fq2JodkShqFuIYNN6bQoMSkYUHzV6k1GC6ikxnuLOZNzvI4MXgeOSVO6Fal0tuXRK6KH60y8bKtwNGGPJLMbo/lUCsJfUVYuxeJ6Y2o85qSSZPWuqOLS+Ysilz1Hmq2caaPl5doEbzT8P5auTW7qb7tvFTCrRoDviFq/UnWfdRes1B7kn+WIQuC5b1bbXVvKl+1lhRCmIQHpXhvpvalCFSa4MlVy+cUeBIEu5Is/3lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oonGxPuEyRsBUoQompzqSzpgheh1W2lKmWilHqH1NM4=;
 b=YURFo4LS93NyFAug+vS7Eel+nu81OX6FIhGz1waPxCyIrDKQR3osSMIiRuiPbi4c5XHXUPXNTuGMDz7ZlA/2K4tUNCrwiTiMQezv7kyXBHRrQ+aRQNBsJSf/voF69sbcL21m6d15Z2I8xFUWikcZWkBmPrDCmN7CpAXUZiz1/xgJ06G5q4oq3/xGfkF3HpDuj93hzh8AKz6hz4F4pETc5iQzUchFCR49Ky4CHPIohO3+SK3TpB0uEuQkLRlyRhYLs2buTtvAZ84rDoecHSGhIEP4Ec1SB19eLJhtb8ckdJw8KLHJTWAdZsccJf0r62V2iZjy69rkssBmHk0/RV+m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oonGxPuEyRsBUoQompzqSzpgheh1W2lKmWilHqH1NM4=;
 b=o/C7oOJgzVFq2v5eXuNexgujqsSZVlI0pj5t88je5T5A4ivwYp5CN5lc9jbZCmtv1BVNRMj8HBqY9CBmyy9g1Mq2psOZY17TzSTdooE0Gf3SM7yy2taBsyooHFXJyv0TQ0OZPF/nvQfOBSMEugCvxuadsnfydnWRm2Kg2StW/+8=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 00:47:18 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::66) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 2 Sep 2025 00:47:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:47:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 17:47:14 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:47:09 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 11/11] drm/amd/display: Promote DC to 3.2.349
Date: Tue, 2 Sep 2025 08:42:56 +0800
Message-ID: <20250902004532.1833436-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: ce199d32-95ae-45c6-8d21-08dde9ba447e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aiHtzFJOCnCdhSxTyPar09vAJHYTkits1h/L755SSJaRLnNfz8fIwt4dAbRl?=
 =?us-ascii?Q?UnGiJX7e9HiIDUVz67tjgH8sdTXNVyt8oZLe0JNGjKeNOsxMUit8F+ebejmo?=
 =?us-ascii?Q?HV2OW4HXkVhzDsF31QsQE7ea2e9vbY2p/a3q9YacslZ75SHE2qJYxawMQ6aY?=
 =?us-ascii?Q?M73K4LgYE2bu7zFl3Z8QaDfjsmFk8btKn3UeGGWhV/+9OZg3O8ugx3oXxkTc?=
 =?us-ascii?Q?jpuv/9r9qUKLOQZlFwCOSdddeVK5pN5IkH2IvAdvhXTh0JiqYeujPHvflm/k?=
 =?us-ascii?Q?XbjON8KpWrgGfVQ7qj65HI0Ph5IXdmFHGCuktJB9H8AoYaXtpBoVa8nROQ9V?=
 =?us-ascii?Q?AZeeW8OhN1BZ+NDAFaRtjEeJv2FGyePEZukypip2MbAmBJ0RwO/VHD9XZCyA?=
 =?us-ascii?Q?+tYhuK81ivAYtZ6ZJPIJ34vePxXvcLf1O3wJPUMpPfr+yuMwr/L2w5Hj4RTp?=
 =?us-ascii?Q?H28phlu3Q7EN79hPeJvkml84z5F4MHldz6cUwAFFNE0cc+6f3lz1dAKHCJsI?=
 =?us-ascii?Q?80lmLxlWySaOzQ3JU5lgJD9SNvIrE97nfCv7qxKuZLFOV0EsZ15+cq3VmCYm?=
 =?us-ascii?Q?57LFicmgVo2YGGxGO9dS1/8ecLCXTX/EKNsbqojVsOyNFELAbrNkfbxRKQjT?=
 =?us-ascii?Q?hz16911RB1ifSSy0tmH/VlULylZNct+od3LcSouH9Ilg6ggKyA9v0CbkRg2I?=
 =?us-ascii?Q?Quw75aceTWlUIo3FwXDZFtEcl/IbtBBTKBXuowRwTC8OTgVoJ3IAu+3lpUWs?=
 =?us-ascii?Q?tkNZlypFCY23e2+mC65IKoXsK0PAzEWsund7Q0cWDVhC9v2MPq+iJPdnqley?=
 =?us-ascii?Q?MNhtO1i+z35pgT7xk3kCy4J+OcHVNnuHFEmYJXP/vmF8yOPL8v9y0WYff78v?=
 =?us-ascii?Q?npc2oyaIgN1oGK03XShsoy2YRdYOJwKg6VTpeH05miiI8BwqlfA8F0ts2pGO?=
 =?us-ascii?Q?dtNrP4bC3tLruvEeK0tdysHpBIzZ0F8FqMBHo8fi6UrLfMc8UTomz9vi8Mr7?=
 =?us-ascii?Q?lvKVv/bbk2NHLYStaADRqufJiJmQki+AD9gqi1OuKCXGRrFvQHWSScotE9iJ?=
 =?us-ascii?Q?JG8ma+vBrpZatcNmIFzNBc38/mpoMB3MMFO3h9aUNKARFLXdNau7IUrFTfu8?=
 =?us-ascii?Q?il5irvWQS4qlGbByE78BiDMHaBqPGVfEkefESJK3O/UpjfDYPln9Jz32zF0M?=
 =?us-ascii?Q?UT2kWlthq6GMLUM7BiZj0x/4ByghpBgispSdgo4ZPzFBW9KVYGtBiSG6G9BI?=
 =?us-ascii?Q?NPgFN4sXuUXNVoLHKGSYkkPRGPDCMGImDI1l8HPeqkR5ZY6yKctI2PEBL8Mv?=
 =?us-ascii?Q?lSoztvFwtTVHgUXrHPAX3kS7FJ8VDxEOoAoSQeJ8CK6MXoK6H0AoYNWIcTLu?=
 =?us-ascii?Q?6zgcqvuK4q5KUtOti7cI4dJCGsqLE8Tyitb3Ko6ivsB1kPqvNHCMLzeCSqpR?=
 =?us-ascii?Q?6qb1b9vtV3qrtgDx8K6YpYQDDOPWHYrzECDSEy8xLPn17x7LWxKsfwCs+TlK?=
 =?us-ascii?Q?fE/9L5ot90p9jF30dBv+n29t0NZwyTp/zNnZgAxkrEPV/XV5SZ73T8jQPA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:47:17.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce199d32-95ae-45c6-8d21-08dde9ba447e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

This version brings along following updates:

- Disable stutter when programming watermarks on dcn32
- Fix pbn_div Calculation Error
- Correct sequences and delays for DCN35 PG & RCG
- Define interfaces for hubbub perfmance monitoring support
- Extend to read eDP general capability 2
- Indicate when custom brightness curves are in use
- Dont wait for pipe update during medupdate/highirq
- Add HDCP retry_limit control parameter

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d32304443abc..fec056d43535 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.348"
+#define DC_VER "3.2.349"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

