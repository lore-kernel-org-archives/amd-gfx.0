Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2BECCF2D4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 04:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D870510E19C;
	Mon, 19 Oct 2026 04:19:42 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA510E19C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 04:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss1LcGNGAxg1gF7I9aU99VoFkLa/+9ufpfcsJdLJQL0dlhe1m56qAgZItmLWZ5cOza1dsvK5WSfwk2kA3/N5sePJc0KcDbWOkyxckXSjKpRhrJTY8SKgVuFES3sAFfc8j+4hWDFoKT/pRkOPLaKjkJz9JOXlrHK/LVnnU0fUknPbA2T4Jczp96bsPU+S+LgL2gLo88XnOKJE5WZQhDrNUc8UyG/ivndW9pi8bTsKPfMUz7EA88lzjfxtEXuRWVxMb7XTeGKq3k1x7EX3YQNS89vdf2a5kYgZSEm9wz0aC4YVrkn2Z/A769RR7dO7VvFQoFFaS6Ohq73l1wtc8tlsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjPyt6q2QlIHvzzldboQW2BAGBG05WZzML5Hyiu/1wE=;
 b=nI0OHJydWin1IVH/kgh40w6nXcZlfxf1+qv3lXIUASUEEo5cYcSwG4lmhpcus91omZDuJJ2k6XOvE6rfO0uhg8N/lpbb/uac4nrAtjikI9KrvTbwnuPML6jMmEX+hbeURvXAbSsN0WmHLI+zevcppb8qy+eocBRMnEfTtlezGOdXeo/RhMEex6ZyDecrrcXbkzRKGvdudzTo+lIhmhAeylKl6b9Ow6w4wTukoYeRgjs4McE5UeqiMKu1vaZdMNBE6557stJ+hw0VNQ1MG+oMwnQezAAkk7VJ7ftH1L/CmZ2bvQ+1/RwC0zAOAOUDttF7oN6lJTFuEaT6r87lhuQvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjPyt6q2QlIHvzzldboQW2BAGBG05WZzML5Hyiu/1wE=;
 b=Iq0+p/M/tr4BQg0638iIp8KA12r/6wbM47VhmhAHOdFubEJimYyln2OdvF0b+B9zTTYeYultmI4yZacyWue9pf1IudC/7acQ0qGyIV0arMqfTlzfk2SOHDjNwgmXG2DnwGQmO2Tj+UEy6+1PxP3NEK43mItqqxy0rk/Uvb7p3ww=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 04:19:30 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::53) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 04:19:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 04:19:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 23:19:20 -0500
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 23:19:19 -0500
From: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <raghavendraprasad.mallela@amd.com>, chandagb <chandagb@amd.com>,
 "Chandana G B" <Chandana.GB@amd.com>
Subject: [PATCH v2] drm/amdgpu: add the new optc_underflow_enable
Date: Mon, 19 Oct 2026 09:49:25 +0530
Message-ID: <20261019041925.1304193-1-raghavendraprasad.mallela@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9a6bbb-a99a-4c00-77de-08df2d982b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|56012099006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: DMF+sn+MBttxv12LD9aShzOCPtyTDZLlvBbFTuKoz9xrlAQOR55+AmzTj+ciG1aakqFKRTVTqRcIP5s4LzU07u5/tkwuinQNQTvTDWiglP8RL3EGssJvrfDpcD7o0ygtWnqFEju7wOuOe1VXMW4sVbt6TLbrtCHjNiFzE1n+eL1kHzZBbpIiDBYq0j4ke199zeXSNjuQ36jtGEIbeV8HVOm6opPDB4wBT7t6e7FIutaAFC6GeNWNccXxQ9/Kwf28GCvSHOplCNGgW8hR1Q0gh1fb3WZdHPfeW19gjVAt4P4xWuB8Of07zZL6zYsGYVy3s7aDpDe375bAeMWGa78MNfJi1FwEP4xKaFx6ZAglPm+24xzEoO3TKgzgPb9cFRVlaC71aWZ5Mxxoun8wNDV0Y0JVpGKf9s2IrJvOCKAxF8u+FYu14mSUpXIhQw3M/LSgsMb38cARHOfB/o2gD9bauAuMhGqmX2QJL6jNj8KCRw8+yxqXRZ2pUl5BIaUSt/faoNM3XfZyCP8antFz7C09Gv5wJbTPKoPIU0pTIEMGEDSyZDGh5Vmb5rAypa1svM5FbiXMgfR0vEtCFQpgB+zgM+RM/QvZERUTZHywUKs4BF6Ux3BN1nlT72akpNQWOkpdppUKgEtX6JH/wQJnUzUsQqzED4H5E2bp9vGGJlcvDvMRvvJrBZ0X4Uj/wdbtfAosBp15HxwY6HpG+iUGXO7xlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p3cZTQ1it/yA3SF9JXb0UQAX5hqlSEJDn5P7I1jEIQkP5aMEZcYmYlglydfr/rz4UXs5WD9TdHoYY3qw3thk7LrA1ia63tzAQ32AoFo4yeLyzcZ/wE2dkbmm1sELkhjnZA92tL3jVW6JpNBrOi/ITO7RS7ukEqzSiRw5o7PGUkGwZCxoFNC8YWgodYM5vQ+IfvuZHWEGNZzkEjvC+Eh4bSrY4mKAT7IiKrq8h4q4wo51kuyj1LFoJz34pXLP9IMMfbu9QOX8/yT4jLPoa0LGua6ocYctcy2pgsAWhGy4CJDKv3VoPBf5wlsl75eh9i4oDE6ENbJ5fuTU/bhSEe9090MuSmIvzJttJF44RLCVJKBaZlJzkbYW/1hljdYrdH66OTnvY2rnPeF1VPwlt0q6W7bZO2fH+/jSYwC5FaERwIQDGMnyrbMpvvgoetbXOmdS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 04:19:29.2539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9a6bbb-a99a-4c00-77de-08df2d982b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

From: chandagb <chandagb@amd.com>

Use a reserved byte in external display connection info
structure for the optc_underflow interrupt feature to be
enabled or disabled.

Signed-off-by: Chandana G B <Chandana.GB@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3d083010e734..12c00a2072ac 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1324,7 +1324,8 @@ struct atom_external_display_connection_info
   uint8_t                  remotedisplayconfig;
   uint8_t                  edptolvdsrxid;
   uint8_t                  fixdpvoltageswing;                         // usCaps[1]=1, this indicate DP_LANE_SET value
-  uint8_t                  reserved[3];                               // for potential expansion
+  uint8_t                  optc_underflow_enable;                     // enable OPTC underflow interrupt
+  uint8_t                  reserved[2];                               // for potential expansion
 };
 
 /* 
-- 
2.17.1

