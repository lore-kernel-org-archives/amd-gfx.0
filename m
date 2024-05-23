Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33727C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC6B10F2A5;
	Thu, 23 May 2024 19:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3uA6+YfH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D011610F2A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8hq+oTqic6HpITAcQpOgPHqMfj6L0gOed2+T3bIwoycf/CvFNV2Z/Vqt6PV5t1S5FvPSZRpaaUarNXKT0xOZRFNX5zlSITb/mlyUF4uHxx86QE3d5Mt05ejIly7eNjWx9N77XrYZ9pZMWtQodOcuvdC2p36zifjM18xUAaU5TckonO9GQICzV92KK/P836y5RNYJl5tq9nPdqUYcHnp2FtD+qkjnIj8xkdm9IkP37vViaCbqK7ErYAuzCGbJBEHMzK6hXstnSXmIK8QqHJ+8K1FuaaC8eqxIFB1kwouj0qeycJxceFWX3kNbFW8AQjY1CDY6minhgw+C4scp7SdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfjgZLOfjXKHXB28CFctDlSrLZJnStlI55u/iIljtBA=;
 b=iXIcS5tq5qBHipNj6ClCgAGcWvsxlyww0JzGGl+cEAWKaWZlJm2fkL95iWlC7gg8GSLjysHjwquxAGAUyLMebSlgsfhCulKxHFpA7yMZQsc+vPJ6ll4ZpdbvtTBe/CIIWgLIo/kAKCodzNii5gt0pF0B/7nbByqyhGIdfYG9IwyMv6Jj9c6xWcRt9pZ0SH6n9kHAoBDBzG0i2EGgG7gXqN1JlnmKmfDfGl2VfaQ7lEdZt2XT+jAqREeaQEgmV14CzrRqk6exSLXEO8RfYzH3uFESebLNw1uCtpDTLldOKCtxDCV3SmWmfc1NyekvJE80Nbo1eBK8yDZKvgasECRLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfjgZLOfjXKHXB28CFctDlSrLZJnStlI55u/iIljtBA=;
 b=3uA6+YfHKTNUzxT/UnAV5eBNf4GfTt0Fwk5+kiHGsfQts9df7m2C8xc5wt5JIR9QXRNVZc3XG6wcdwTSkv3uIyW7Yj9Lde2FChjqSUbQi6fMExW3TLasxIaUiLGEQ4EZ18jBDnulD0S200M5BX8T86k4yqcD6vCSEA0bSc+WABc=
Received: from CY5PR15CA0113.namprd15.prod.outlook.com (2603:10b6:930:7::18)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 19:20:51 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::4f) by CY5PR15CA0113.outlook.office365.com
 (2603:10b6:930:7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:20:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:20:50 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:20:45 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Pinninti
 <bpinnint@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Refactor HUBP into component folder.
Date: Thu, 23 May 2024 19:20:18 +0000
Message-ID: <20240523192027.50630-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cebf79-06cf-4cc7-4dd1-08dc7b5d756e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lb4exE0uEUOlQNdep36iARPwnbkf5VPsNLYHhvTwEJMM928YEBx/PhIJIkPI?=
 =?us-ascii?Q?G21QGZIR2MdMPuobhT9SzY4b8BWK13+HbFoh7HJ9GH3JStQtm/iGnIMvw+mK?=
 =?us-ascii?Q?MQYcELw8B1HlXb7ohrLtuS1vwpMBoccS3g9sgl714ufix/DGmz849Q+Tq9EG?=
 =?us-ascii?Q?VOhVxmxLaVAXPXWIZHAp4OL2yC5K7zH+7oIbAfeJqi6yqzP092K0rTdoV+To?=
 =?us-ascii?Q?lS0f3QwIZ27hLOHi3MdutNYxWgNROi5IPctO13zXT3AkZkRmfH3pHTgsQcC3?=
 =?us-ascii?Q?gXyR/D924LM6SVyAk+Q038JhzmfVVGudd+5vK3C4ytF/D5zz/QpmBf9fYheQ?=
 =?us-ascii?Q?sUNInmfziVlIlle4NYzodO9dF723OPOm6T6/UbPP02M2qeMie7ejYhy2Wh/X?=
 =?us-ascii?Q?awFbHG60wqRQvVLQY8u5dt+PoZudOIoFAGkCBjox12tziZYblOdwx0t+j2zn?=
 =?us-ascii?Q?HLm1z+niDq+pjK7+qQT+OOHH/FuAZgHKnhddhnDoZOIGf+MtcmdjPpfpeaVw?=
 =?us-ascii?Q?EwBR5yqOIsUcAlIoXim1Sh2cSGGrKKMh5/kWHt785ADzSjIdUaAf/VOIJABK?=
 =?us-ascii?Q?+TzxTFZ9zMkcVrOMB6VbljG/PMW5aHzrhfYvdOAl1hID8+9xhiNMuu+T5CJt?=
 =?us-ascii?Q?6j65iTlbd4Tx3liydOSVrC6ycBOyMV9fBnKQG8W7/MeXgvG+I3L/s4RA2mD0?=
 =?us-ascii?Q?6yr+bbiJbMiXoft2ty4zU03ALTcBq3EmZxQ3/n8aP3WFHShVt4MgUrBgoYMe?=
 =?us-ascii?Q?amQMYIQ79Sm3/lYG0qLNHzVUexhZ+8VAiSLLRpjjgpQpajUz1xuzI/SHh2+s?=
 =?us-ascii?Q?/P+jUGs1DQz+t7bpI0+RHakzR/IyQIoEFXaZaDdrjuzA0CnGvEgsh/mdE7z1?=
 =?us-ascii?Q?Ytl8GdXjXAnqV3GDtcDVG/0DVePcqmJAMkDzCydJ2oBZnjPJZyuOyIX/jrYL?=
 =?us-ascii?Q?MUaUEtE9+XRsa6xheYF9A/jV+xksBTlWhijLiZL6pea1f8KMlYZqAWTMdYTs?=
 =?us-ascii?Q?Lrrbmwqkj5F9vDVrdDVKJeKWPnd8E+5qdbjwEnZ9yVxNSUz/LmzfXgEkc+us?=
 =?us-ascii?Q?6Z1qaoUjtP1vXWzmF9uIdOsO9DsKcYeZxrpcMdboYCET0rni4c54yNcgL7Iz?=
 =?us-ascii?Q?TTczwQhUnm9s2Xig6Jkm6bQHtuGcoZ2o2mXDpXtV3+Lmn7i5X8LgipzjPmcs?=
 =?us-ascii?Q?tde2zJkBK6BxgeYiaMFTxmteZNvXQ3B3Mof7k7+6CZKczlrZOZTBemnhWkhV?=
 =?us-ascii?Q?T/2QYc9FplLQnWnDzuVlOw+MRuVzQtaxlAfyKduZv2n96qAjXhOoCRBLJZLR?=
 =?us-ascii?Q?L42nNRshVTQI7jnun3w2Tj2N3zpDVZkrHCfeCAxPvDG/cveCdJIqfVjVKosm?=
 =?us-ascii?Q?ljvLKBQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:20:51.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cebf79-06cf-4cc7-4dd1-08dc7b5d756e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

From: Pinninti <bpinnint@amd.com>

[why]
cleaning up the code refactor requires hubp to be in its own component.

[how]
move all files under newly created hubp folder and fixing the makefiles.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Pinninti <bpinnint@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn401/Makefile           | 1 -
 drivers/gpu/drm/amd/display/dc/hubp/Makefile             | 9 +++++++--
 .../drm/amd/display/dc/{ => hubp}/dcn401/dcn401_hubp.c   | 0
 .../drm/amd/display/dc/{ => hubp}/dcn401/dcn401_hubp.h   | 0
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn401/dcn401_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn401/dcn401_hubp.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
index f3fdfa1fba37..2989e706bccf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
@@ -4,7 +4,6 @@
 
 DCN401 += dcn401_dio_link_encoder.o
 DCN401 += dcn401_dio_stream_encoder.o
-DCN401 += dcn401_hubp.o
 DCN401 += dcn401_mpc.o
 
 AMD_DAL_DCN401 = $(addprefix $(AMDDALPATH)/dc/dcn401/,$(DCN401))
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/Makefile b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
index a25a8b216e15..a2d1128de7a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
@@ -88,5 +88,10 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN35)
 
 ###############################################################################
 
-###############################################################################
-endif
\ No newline at end of file
+HUBP_DCN401 = dcn401_hubp.o
+
+AMD_DAL_HUBP_DCN401 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn401/,$(HUBP_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN401)
+
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
-- 
2.39.2

