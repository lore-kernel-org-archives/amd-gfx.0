Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03293EE57C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F4210EA50;
	Wed, 11 Sep 2024 16:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="01ULACHO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA91F10EA50
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mohQqeaE0z68o2Oh0WFAWlzw2KHTe5q7H60uSBHNS5J/NTjz5H8+W4uhqJ62vx26PdEis5wKIctwU4NUEs5gWA2AzQnxX8vtTZrjWJaNNaXeZyodc3DERtvYmZm+G8q9NrMwMJ/yQ9HjzxBbmgur5/WmGg2D/FCVZFtuDPUYgphP3WcFTuRPHRGHd3245OL7rdswaxTJPq1z+7u9i7D6stu1QSL9aeXxmwqNg8ruRV4s0cnEd/z7yGa4l1XUfDmEXvB48Cjw8GLNBLOpRPqnS0Hrc9eKKReC/mbQ+1nnb/4jpPovk+LoRTVn6QypoftM2Qt6STClUloKyrtlTWhSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMjpj3EM6K67UmKYzHjytdx00evthOT9qi5ff71lLec=;
 b=kKbEg50W6F+UaQtqMPbcdy/peo+GeSDFn6TUucZIoYyy39lfXRpq9Sjah2k0qJdr+YdV2rYde1DbbaLbi1ZO2ZPfXgOy6wr16JMMvjGrmyXvVYSNOQmEpCTgZtHABHSIV67hPE3UtQHfo/6VH9KMTfc66h8leaDsl3264wpqI8xBU85Jo1wTUPwhdMhs0CNzKHh8gDPgMopmt/jJJ4f8qxrfkvl7lRKbZeAUDbvo3j4D0pRQm0MM4DYRdTXKhjXd1/alJ6QbqC0SAjseAn1Dd1cwcvc7x/M1uJAFv0lRRCJJkj0kjvHwsRyDwLmgPfF8bry/YeEN62XjS2LZqTAknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMjpj3EM6K67UmKYzHjytdx00evthOT9qi5ff71lLec=;
 b=01ULACHO1t/m2AHpwsdyTZjQEqblcrNEAmpD5l0iio61G83fvM0cZNCYR72iAFXZwjtZLHJztscUQH9yWfdp4kMmJ8t4sIYvbYTz5viKrWX8H75CfBJid8ucwKOyAjAASORBuV/95IwtX7r9jblvmUnZf5/UETecGMyTWc67uvQ=
Received: from BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::10)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:22:47 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::41) by BL1P221CA0023.outlook.office365.com
 (2603:10b6:208:2c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:22:46 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:22:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 05/23] drm/amd/display: Add dmub hpd sense callback
Date: Wed, 11 Sep 2024 10:20:47 -0600
Message-ID: <20240911162105.3567133-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c21708-112e-425d-2ef3-08dcd27df8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cZ4DISDuUsdlSxBm9dFU7XM8L+FM8rRG2yxVuEKpjXtHX704r6DSEz5EwqTA?=
 =?us-ascii?Q?qHlCdPoqxU8p0SbMMyvtXx1tP4FAUzZNkYgr2wCEZjm/XvP3OEtGSOWfTofv?=
 =?us-ascii?Q?TEJld9HcQciAZC+GuR0NoG/2rHbgUygw7ZYirhBS6Pu18IXomjF7kY78zQ7+?=
 =?us-ascii?Q?Qa2n3RsVxNztOfW1nCd1DnzCbogeAF41F0Nrv1Vj+4KzLkzPxPEZVaVlTeDB?=
 =?us-ascii?Q?FvsCShUOAq4/OSU0GLQlHGS1P33DH3IBk5hOs+hT2+Lc7om59xsKC9oTRcXm?=
 =?us-ascii?Q?9v8/T9VMSbSF8GU/eO764C9XoHn2tYM2UptGW4pAes2x8dh9p5mkkEDinZag?=
 =?us-ascii?Q?PHIF4wR60H7UVq5gFXGUPLmlhRUhjRirk7g5Bz7PpYVoMj8HPg2gnpqLQazf?=
 =?us-ascii?Q?0Squ7SKjyGi56J6gzKEwrn3Oyv/hJEVg60VLyNRm50WYPKz0cdf+j9EYAbvm?=
 =?us-ascii?Q?UGDZRJfJtjEgWmGXvw7WhE/yxvbGNt9h/p3Cs+221gep8P5r2FZyGATKD1QZ?=
 =?us-ascii?Q?GU4l4gj5c8YRnW225rQvVyfrZWlYiqRcGM3zGLE6BKfoZCIUrOLfILvNCb6C?=
 =?us-ascii?Q?wf0XAlKOtie5WpWr8PFb7TN1kPtdwGz1fZBfqQBfGgJcUqyd08z3N/6qlM64?=
 =?us-ascii?Q?9z/CMidAaxLVlBp9+KLO/rsucsp+AyaJD5NRyIsPyxQxGxL7z/xMpmGdftrf?=
 =?us-ascii?Q?XfocLYwfaCMQ84VV6uyZcr25/EsYSmSYB/WuQRIFBCc8EtJ3glG7vsyP2bI7?=
 =?us-ascii?Q?lz4WYV6xMIkAHlBXwQn7Sb8m6ilyLpvWdJno1DDb4wf7lhYaPeLhsJHCha+i?=
 =?us-ascii?Q?WqH/jVlvl46aKDPKnLdIuOWAz6NyxwLggvKuF13jSGhTbEHrZHgb8GIVnKqN?=
 =?us-ascii?Q?+gC4iyg0ykzwkRu/0RtTdhojMutsm72tZrzDWNPo/g2Asau8UrrrWS+Ilvlp?=
 =?us-ascii?Q?8YvnytpfF17SmoqYrwU4gz/kEaQDMTgvhVIu9mluh/hRkjAlkIIaQZFXrkuc?=
 =?us-ascii?Q?cnrZCmFALNPqoSCCnqqectINcSotBADGI/36FJmW2xXXCl1v6pRFplzfD5Ut?=
 =?us-ascii?Q?4U6/cvVSWiiMA1HXVk5Fn0tCxP3yR5rRxiKvU5L8P9HpsUjgfWs1zqdDqHE/?=
 =?us-ascii?Q?wbQCE4gp2OGdEEAaCnQT6zg09eeDyfShMfhYxIJlsOr2IoWnX1V7t1jzDTAr?=
 =?us-ascii?Q?BA5A1m5JWwtkiqozGkGkqRnQ5P8nfrRTj5xsSr8tseTMMMmWi4ZZ3pAnKth0?=
 =?us-ascii?Q?oL+8QSfMIW3qRShGg+TcaDbK5+Gd6Vjz7qqMCcrkxTFtr0d89hUQFuE6liwv?=
 =?us-ascii?Q?+oQPx8QWOgbGEpsluxhIJFpC4yOEfOuJpLd7v2+hqZ+RY6DOf/Ux/x6W+DZd?=
 =?us-ascii?Q?l1znVF4cVB83lhhaBBuisILweeZRjCP+k35KpW5wydwCKvyXDpBODd7jgEPS?=
 =?us-ascii?Q?VwgJHOSP1vtIvKkaukGFbG3kEbn5EEYX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:22:46.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c21708-112e-425d-2ef3-08dcd27df8f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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

From: Roman Li <Roman.Li@amd.com>

[WHY]
HPD sense notification has been implemented in DMUB, which
can occur during low power states and need to be
notified from firmware to driver.

[HOW]
Define callback and register new HPD sense notification.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a3edaf658ae0..c77982245f60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -807,6 +807,20 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * dmub_hpd_sense_callback - DMUB HPD sense processing callback.
+ * @adev: amdgpu_device pointer
+ * @notify: dmub notification structure
+ *
+ * HPD sense changes can occur during low power states and need to be
+ * notified from firmware to driver.
+ */
+static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
+			      struct dmub_notification *notify)
+{
+	DRM_DEBUG_DRIVER("DMUB HPD SENSE callback.\n");
+}
+
 /**
  * register_dmub_notify_callback - Sets callback for DMUB notify
  * @adev: amdgpu_device pointer
@@ -3808,6 +3822,12 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
 			return -EINVAL;
 		}
+
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
+			dmub_hpd_sense_callback, true)) {
+			DRM_ERROR("amdgpu: fail to register dmub hpd sense callback");
+			return -EINVAL;
+		}
 	}
 
 	list_for_each_entry(connector,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2d7755e2b6c3..15d4690c74d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,7 +50,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 6
+#define AMDGPU_DMUB_NOTIFICATION_MAX 7
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
-- 
2.34.1

