Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB93FCF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EBC10E764;
	Thu, 19 Sep 2024 18:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EEQS+A4u";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F32810E758
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxWY5pOYu3SKEZ1Gfgh4V+rPly9N1CjAmei9rV4gKbd2buM2mxgot0DtUhv6q1/zw+6DDlJyPPVxk60ljHzMnkYs39DM5HkMVVrPU7LoFWWVy26kmJNwZwro8PU2tragCBVuCJ+zi7xQMY/7dLZjibmeXgRtybsuCDjBWnU1JUPVGPJr6XRdlJht3VKdWqSUE3MxbS/BwB3BGJTDq+SGqztJ64PA5YBJPqDO7jhUfngRaessw15LOAbE7n7ui1M+tAhOvAEh8DwnuN1wOs44OQkAFufqMEKORKYjsNQExpmi0EU4P2bm4IaoseMan/5Nvla9gRs/j1xiuN20foqO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA74kwnqf48WkfrZZ3zEkma3UmAGm3jDBQPWi5VbBUs=;
 b=KCMzKxKlE2vcNHmOiKgucaKkaPH8fwUpPWNmeRiGSHzSiWTH7bw5aEDW0QBA9aQr3uyvyVtIOHmlS76EcRy3pPZeP2kLx2S0+iFYU0rknxPg/zO2H+SpYZ8oNCM5DEKt3WDVLM43tU0aYeKj6eLGp+ztxtpyLT3gzE2D0huNlbqxSwqqyLOI6RPlSO11w5slBUPEYyWyOMYCJVv0ddYQruLnpE9o/JT5eQdj6T5AmwnfNG5tI6dDlQqe38uv/yan/LcCHxWr+snvMxdG3HB9N/Luj1zsBDRqI/jUxcHyrLlo/N0LKLmIJscGLU/h9CC4RzFLRIVT3rRdj8t8ve9bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA74kwnqf48WkfrZZ3zEkma3UmAGm3jDBQPWi5VbBUs=;
 b=EEQS+A4uL3mTMziakXhClzPHQC+F6AUzdCDB3t2h1eNmEmOb49wBw07InT8tWRwrO6osbl0SCYcUxh4bGSUNZivNoMBssJrKPbUwcXht55x0mUdsQ3b5P1evH4pbOzjEJ94EYMxk3Us8RruwWzQn2FvWNQEx5hhPrJiPYnOOsaI=
Received: from SN7PR04CA0210.namprd04.prod.outlook.com (2603:10b6:806:126::35)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 18:35:09 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::b) by SN7PR04CA0210.outlook.office365.com
 (2603:10b6:806:126::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:07 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 21/21] drm/amd/display: 3.2.302
Date: Thu, 19 Sep 2024 14:33:39 -0400
Message-ID: <20240919183435.1896209-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: e3930334-374e-4325-d202-08dcd8d9ca02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3KqJoNbp9sLdGWzTIfuj755XYIzAhyl0yJW1vWixKoxE5boCsADH3fRSGcC?=
 =?us-ascii?Q?qRnTX4j6I++Z0j+28m/NOjg6XIpCw0owcTBRhbo76RewJCclXHCSf0rG+LZi?=
 =?us-ascii?Q?R7gUFIOepp5t9xzO71+tuMmQk18lwUFQT12Qwpyv76Q88hIGCRQhSDM4rkKz?=
 =?us-ascii?Q?67/zNfnXWsWktdHz+F2Cm1Hg5ZXOlrYreeltK/+skNMh/W/r2OguXaHmimAc?=
 =?us-ascii?Q?MUUQdjXJAouKbyt7/AeZ1qiByzcePDhjAXu2l3tu5OXdr/hU/eBTaAShOQI/?=
 =?us-ascii?Q?Ff/kA32MDFCv1xA9FaAf4nN/cmhyN0FJ2xwu0pTRMjaVWaznL7QWPTtH76bf?=
 =?us-ascii?Q?iH+C3wZg5zAgfkwAr+aLlZNOUOzkEhiqzvglQ0mko6XrOi97JhYUiJY6zNVJ?=
 =?us-ascii?Q?JS+q0uYJh3gTNeIcza2DSval223JJRa1RPR8AvNUqbIuIvZqD0Ak5jdbcg/u?=
 =?us-ascii?Q?zugn6emwIxnOoJqe6sAsxMaO6Ft1aT7/vlASfSoTKKiEbkNrmpzjtqeUuHPS?=
 =?us-ascii?Q?yItuEh2DQwz06h/06JnYFz4r0KjgAy15GrbnpnRdBD1gdws482zWdQCkwQ/r?=
 =?us-ascii?Q?W7W35HlELAm9vEwl+8eOdE7l42NoTIpSTlC+nI+fe1ASeCC9WTx/aJ4uPd7v?=
 =?us-ascii?Q?HkgojXFGRYrQu7143MACZPVGQisWoWkUO9YnxyAKvgLz6nEWlReTywvgUoLl?=
 =?us-ascii?Q?84OAa/BmbHoWn0u16+rtnjRm21VAeTvV9Zybwuc1Sq8/FiXOOaB/hUM8Y1xV?=
 =?us-ascii?Q?cmlPycTxBOnLFdU91I0lkC+WUyJPTlHv2DBwlPAN78KEK9325EXC5ffqVSew?=
 =?us-ascii?Q?CG/wyJ5vnOewl6tLGncLorcQPqudfsKwmrxorbrtX9R9dLB03u7LPSRbR8/I?=
 =?us-ascii?Q?LOFFt4MwDXGGc+CFAaK4sIZ0W3yZARQAW6HLjgEayDljhgx6p9juZUYmszcD?=
 =?us-ascii?Q?YtuUIbPG52Ev1NCFaJBu/zAlapJzjFwYTQgEH5U2ZczDlNnMYwV6U0ZNO41f?=
 =?us-ascii?Q?KYkX9ySkuOXomMhx+DpB8ZIIjoQnV3w4STxXniwTtrnPk1UCqjI2jg17IMfY?=
 =?us-ascii?Q?vfJcPtrFiVzLSII/s0VCohiJ8jiT0f5ubAIeE+iMZ4caJo/qtOSybt+xWoES?=
 =?us-ascii?Q?GzCLSLOaweFhdhlpWgA+em7sjF+gC+aLQIOflicpI33z1CrXE6UPhZ6st828?=
 =?us-ascii?Q?YwHxySa40MkY/oHTEPXeSaU3k2p8wq1mNwTfJOPi+bqOS0izk/UZVSLE9WYE?=
 =?us-ascii?Q?K6yjX6/8lVGCmHiilOt922whK1cLGWk1GyFx9t0eL3nZwWLGKthC1HwVO9BO?=
 =?us-ascii?Q?pLpJG17cdJNITladSwXjCwAvhNjqB18O9TdbX/QAQqEkA/xQRA+ANx5uKPD+?=
 =?us-ascii?Q?5/MlYd+hXgIYZahKyqDiIUeLcj70jCFlDBFQ1iPZE0BRXYBzXooBSA+UNoZz?=
 =?us-ascii?Q?8J5pjDhkp63B0cNnxEhpVglNOmory7jY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:08.7828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3930334-374e-4325-d202-08dcd8d9ca02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6d60f7597f88..51fdc0085935 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.301"
+#define DC_VER "3.2.302"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.46.0

