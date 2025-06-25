Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF9C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F93F10E65A;
	Wed, 25 Jun 2025 04:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EtuvWa9x";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8173310E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COaxm69lQuzXMxcYL0RR2FP39Z0Eb92+avkGGHKwwMaFm3HO4TlF/eU9/jjYS4IH8LYk2GBaOQ/vCPsW9fQLe1ePhtAD2iB4hKxjFqnqQK0WOYJPt4AbsVW2ZBHAInJiTECWKzqMCBsL3J491WRdKuoMYt9jtpZgBysOC6xhVtAVMDyQfSj0yafXfiofEVNBtH9nxADHo/03a1Dm+kgpjrI/khPPhpfsG1Kppgr12Ce6u+sKWcd5lOI4+xj/vNrGT7cDI9ZyWciIFcC2rxxamsQraStyXyLskF9l4wgbfhrd7j0zJOi6BegewzhqAuZ8lVoGdGBDUfZmXy54KR5WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+dTCeaEzzKwjC3jnXpuZMU1mBKitQEk6E0GEAh8oms=;
 b=juN1tZa6x7uAx9DAmCofkiHpILM6/IKLGPdANdOJBD1ThYSbbfZjg1SMBBAyE+5FurFC0umDu017z2w/kj1+If8LfmJAYrBfn+RgCjSScYbORA0fgc+v+kowZXs/8BV8W21Z1sLYOEhOtIEexicU77Wu/qGOS19rCyUC7Y2BQvJTugPar31ZjvckrGgK6/ub54W+oKwh9LFbtIuCD9ChfdZQzleNGXSHZnj2C81r5ymvm+jOJs83e4Jhfg7Ahk4K7jWY52sAFRzwk3rRvr9DAsQHps0x/invtv7dzH5TL0hXVRDU3pyKrZOL7Y3RDdBWn+Is1pt6VA4CsoXcIllJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+dTCeaEzzKwjC3jnXpuZMU1mBKitQEk6E0GEAh8oms=;
 b=EtuvWa9xSUp6VEUyBYdypop+YUIwglQGFflsTQcWi037FxA8PaXLvFUkO3+q3yDb4Uw9ajVXs1Gazvy+aF5rpEuFIPLyHpanwwNeDgBxGcEICPPfgBij/kedIjryyDVj79Z+sY9ICZAEKUM9DbpMuR+lgDzY+8x/+Un8N1RZxww=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Wed, 25 Jun 2025 04:06:06 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::f4) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 04:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:06:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:06:03 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:55 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 11/11] drm/amd/display: Promote DAL to 3.2.340
Date: Wed, 25 Jun 2025 12:02:29 +0800
Message-ID: <20250625040420.886013-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 935916ae-6709-4c91-3256-08ddb39d9bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?60E/XeLp1FA5MSqpqFrB7eWkpdeeJ7fqQawCxojdp3pUPPKuP9hthWZZZuqn?=
 =?us-ascii?Q?Guxnl4fmdH8C7UGf5HJW1+9uFQ3QdW33t6Ro9FJmfM7AA0sMupd89KbAPn3n?=
 =?us-ascii?Q?UGEDoC8yjtXqSZnEcmSQWmCcLbPmamX3IVjSwhhFYDqra7HeDzx5IRoIudYw?=
 =?us-ascii?Q?y2ukbs6tlQmlyfomFh6ZdDVhf79l+BCk4xP6yGTcie18XecWJxKCakpRLu+u?=
 =?us-ascii?Q?pBD1MJqNXjdpwtj0jNEl6gQ4VHzyUhXQQDJVO34lG4kQrLRAXRfykACK4YLv?=
 =?us-ascii?Q?/1en7o/aNUMog2hKq7xkCRV62r7uBr7xI/aqVqgJKsqa9yPJP884gJuwX5fd?=
 =?us-ascii?Q?qWFypGevPDZLmjn74qaT4zvUqmE0YU1AcHbVVsHmbRa/HSC61nyyYsD837V9?=
 =?us-ascii?Q?4ZnsDmuenXmcpDrcCL46kblW3IIHhQ0DVW8GYx5rjOVZx7kr+YApd3OG+Wqf?=
 =?us-ascii?Q?rEDMzzsKKFPf29mJHQ+4NkDT3zZlqx/9rgm+VNNqikg43CXx6Q+tcrxu6iRh?=
 =?us-ascii?Q?DrpnSO+rxTf/oTp1+MefmvTYfpsrOH1N7awwP6cXFiS3dxJz+T+HAwEKPliA?=
 =?us-ascii?Q?tsTacAF0InIAlGyf2De6mxbvHZU2FQAXzDNX5qTwSzn5WJa3m/iT+K8wAAuD?=
 =?us-ascii?Q?6d0gLXMAKtAkHsL1pePyEPNfLmDrpsqoB+Tcj/ODIDM05PD8xfRWZgOp4dPV?=
 =?us-ascii?Q?ihRnK37zVcg/j+U5AHH+fUeq8bNkLoe99at780jCxFUCrcA6lFxDWU7ZJkc3?=
 =?us-ascii?Q?F6uQ3JTrBSVOHIBSNhczBG5l5EUYIwDe95syDwHyjIJlPEMtmP+fXzK9en5v?=
 =?us-ascii?Q?qr3av0vFMFA5ncbfwp2ZoLBNvzAzlZGiK9NddtbnkrlorRJQV7gcDRJDmk4j?=
 =?us-ascii?Q?OnJyTx2kajNIfxXkkUFBVfx7PJlFrvrEkcucF2v/Hmzkad8h3RbNHc2te+cX?=
 =?us-ascii?Q?Tcdh5VR7uljKM9Ag+jQ/u51vXw7gOmTXZRsK8zizDZv9Jq+m57GB3SgFDsBc?=
 =?us-ascii?Q?8ABQfTNZW4/D7m8lMwSxg2oaFYSV04fxzg59fgF+LVrTRN8Evda6eT14ell2?=
 =?us-ascii?Q?2LO5H68yJ2QVG7gbgL65tYcLPEcdRsbyoucPDv900MvwO42jGmGpQjmpDtfb?=
 =?us-ascii?Q?sXpJEZ4unxmhNB6XmKm2ErzHBCTq4HyELCnE1VfxH7tXYzR7U6pZ8XHW7rln?=
 =?us-ascii?Q?3u0THkDGUAQK20HlUh36NlCej+w9ANz6RKLW/gTbLMtSju9UsxnAOh3vuziQ?=
 =?us-ascii?Q?Qou360oLaIhAcEKXM7Q2fZSPWW917R5VcCJt0ANALZ+d7IpCrROi7BYRSJEg?=
 =?us-ascii?Q?FEueIWmJ8zO+7mE1SH8VFsDXSY//XRXlRsfTdKWXX47HmA4qJ9/SBE/O/uCo?=
 =?us-ascii?Q?XiezHZyWfC2Ll7AVD8nQBDQ+vkDVPeKbNh7SzWJPhy8Bx4dbjOm/cXwdbuvn?=
 =?us-ascii?Q?jMyiOH754TZY/Wvc44FOw0T6WpUO52CMMlBkugpN2GUWe77Fhuch6/ZIT1LQ?=
 =?us-ascii?Q?y2zQiabs+7l810PAsnrd9a1Tpm2jfdVUE6eD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:06:06.0694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935916ae-6709-4c91-3256-08ddb39d9bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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

Summary:
* Remove unused tunnel BW validation
* Refactor DML21 initialization and configuration
* Fix link override sequencing when switching between DIO/HPO
* Ensure OLED minimum luminance

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 77773d3015ee..ce1957c7862f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.339"
+#define DC_VER "3.2.340"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

