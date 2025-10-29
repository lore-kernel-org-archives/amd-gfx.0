Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC1BCCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341A510E6EB;
	Wed, 29 Oct 2025 03:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+VawKUr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC2110E6EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th+btLyTlrqsBmkMd+TeVJQ9k/eYoZy0U+CrRCm9fUF7jOwXxwUv+QxYoPB0lYezG1CH+ckvEft/kPaHU75mOAXbJZQi+NOLd75wdqSuYzOB+EIczutjgn1XgnAbQwcJUULEc4pFWbK+Cyip79oJEEEN2irWHjEYNt2j6oouQOQefpxWck4EqWed5CGaex7/ppA+xBn3Ub7sQjwi1eshwm7quVqj0iV8xtwlXul2Vw3evDLqJrxeafhSbeYtIhcENG+RnPP8AqGrAYy3Z/KILCll0E86hEHPyyPVoLA1s2dmbhmEeCb9S3lz+DvrlajI4mO5YWo4sI/C4erXwwy/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGKSHipUOk8D9UdJbrWwvSWtpX938fvv3jHEwxL9QGI=;
 b=f84y+2ZUPys4ONSh159sAvaMxpbDxPQXg8Gq4zMeU8H36zj6obfyyL8oEsGlVyFGr3TDHRsGQEuhW1nrkVyAXv3pVLu01ZG00/BN4mZxVF4dcisj+DltfCfO1RuEJ7TXnakkTJbPZC3moTMI3/7ynlGdbi1VHzRgaSg3L4J/DM3tYYEErgxkfxnn8Bw7xqqRQLYQtKOeTqnfUr5KwrM6bUX9PueHcPDkW3LaHLngZDhLgZebVHJtqb8mtepuKNQu7by4v4MsPGjd5gl5p0ZGDMpqGkdoAuMp50rxIbNjNVe0fesp5wC4Vtwu0QWpBlTELvuwM8vecNgMtfvVQnIQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGKSHipUOk8D9UdJbrWwvSWtpX938fvv3jHEwxL9QGI=;
 b=T+VawKUrbYYI2bF3aYjAYmV9G2gOhoxtAazJxWYbYmaEZ0Njf3RpoxrouIlwiUbiLgNTqmkb992LjLXwyO6RsEtBoMsluwbuDHnMkaA3Aox6hL9FK+2h3UxJuyfI0xmymbzj8fpoG7PFX0LWlit6K6yR/Tjf1nZzKBm6IPI8rYQ=
Received: from DM6PR02CA0148.namprd02.prod.outlook.com (2603:10b6:5:332::15)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 03:11:36 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::1a) by DM6PR02CA0148.outlook.office365.com
 (2603:10b6:5:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Wed,
 29 Oct 2025 03:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:21 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:11:13 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/13] drm/amd/display: Persist stream refcount through restore
Date: Wed, 29 Oct 2025 11:02:56 +0800
Message-ID: <20251029030935.2785560-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: b7167074-cc47-4d52-78cb-08de1698de9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2A6nfo0za/EHiaLC5spnpFH1JiqrOqRHFIdWRj0ZCfuD6YCiEaH1kNdJzse9?=
 =?us-ascii?Q?0kLWF1dgQ15pmgDjQM+wgY9broR73KXfSvSYSr9vhIzzTofKcdApLW6OD6dP?=
 =?us-ascii?Q?7BnDveAsR9EObzUz/cHdpdDr2pC5iex77QOBA3ckbO9LvjrydInTKdJ7Hzz+?=
 =?us-ascii?Q?sGJssXLeWJsHnQFlS0TtzvLhE1Mq6tJjRR0j6mcrVt2DYJp9PO3CNzUqJIUa?=
 =?us-ascii?Q?cBBiUZGjtp/Zjl7+yyUTuNwb1MuPkMWC0xPWw3ABBi4z929kg/adbnoJiiIn?=
 =?us-ascii?Q?UUvLb79bxQGroyfECy1/75k9cBeXyiuLQjlxL6xLbzVkw6ybnNIUVtXMwDYb?=
 =?us-ascii?Q?N3tojGS70cuiZbqQT7ifTP/eTLB0oPF6oLcDWr/SAim25gnud6nUclm9Ikpm?=
 =?us-ascii?Q?ytRXNecjT5dOznw8VBeB2WiVjT3VnkKBIc4vQge+urZzfgjL6s8rPADjZnFO?=
 =?us-ascii?Q?IJ5OERjtVV3KEEWzF9C1OkJWGon4sWqzCbGzMxdiIvqeQ2nAHVEbD9EOtpKy?=
 =?us-ascii?Q?hZhLUUjUzgV/tifM2bcNWgpRtyLG4dkNDyOZaPh2yWeEs8f5xAvTijuFY2kd?=
 =?us-ascii?Q?PbHgLvnGDq0pUsyTR56+j/8kwRvWg2vQbVsh0bjXfn0Bg4zaSXxEq7kSBVwB?=
 =?us-ascii?Q?T1iBP0HMrdLJzsuKBCpHDzg+lEFoa89mYIBQRqSkuL2qBcXTQ8WPsEJEzE6/?=
 =?us-ascii?Q?99NwmYaPnPz3/0nd+XAHdQlgfilJueiNSFQSdru+S4piwwjarap7OxRRJfYk?=
 =?us-ascii?Q?Z40lYBF0wK4Q3lBHR3W//Wja0e8bKaAY2oMU2afllAWpOxk8jGaYb6uBFvib?=
 =?us-ascii?Q?r16237Nyq3+i3KWolH+PZ27k98EwNDm7vh55ffK6esL1H5oxxNCeMhSVeEcb?=
 =?us-ascii?Q?gUI7s9KkQKzrkIuI3qw7tTB9Jcf2sYLare9WH0CYadUgcNnftOKsThsxe5mW?=
 =?us-ascii?Q?w4I6HLeFweO3BAv3GR8t3gVytxLg44BN4DnXEAoNVonnGQfNOkqNq5NVwbst?=
 =?us-ascii?Q?fzAVbM1X2Fm2vnTY38LQ+Dd3yxHg7SgQgeTziOycAjJ7fCApsvyAAKsS14bD?=
 =?us-ascii?Q?cyFGtTPMyVGyxitiLSFKVoB3o9I3vXCqx/TNoe9JEu8oIUTkeKNbX9dETz5R?=
 =?us-ascii?Q?OKeeN5r7EeTLL1NU4WxOCSqcbSZ3UtQSNVIVxePD+EsGsC+5vhTAq/RcxSGJ?=
 =?us-ascii?Q?kUwHmh3TlShhAFb6I6BVgUi8lXP5+LGSlw9BwHDt2g2H9IRVny2xJ3k2Aspl?=
 =?us-ascii?Q?qWgQqsdtBwQbcfl0GZjP2tCtzigoiN5fGPF3ZNp9wZFPnngfflfdH13V/vER?=
 =?us-ascii?Q?f6YExJI5A+vWVoj3Fu+b/ggLuEBn/Qn1QTmSA5oXqKbotYdh7ippEjrhcsWu?=
 =?us-ascii?Q?8ik5wpJO5g0nzQDEFYuhjJBpgw49+cwJEazO4bZhl+LQiWo+JUhYWxU/WMRt?=
 =?us-ascii?Q?2j8coFDFy5boNON+gY944zyDZJmUYFHCEuILaoogLcv2GpuC461gm5+2bJ/A?=
 =?us-ascii?Q?5mZqcGYPCZMuDcn8hVqEUCd18yAQCb5pgIK0O2EepKr5jnSdwAcYi0XCrvH0?=
 =?us-ascii?Q?3aZfXfkVwGky5nGPbEs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:35.8097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7167074-cc47-4d52-78cb-08de1698de9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why & How]
Overwriting the refcount on stream restore can lead to double-free errors
or memory leaks if an unbalanced number of retains and releases occurs
between a backup and restore.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b720e007c654..f519e5893a68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3389,7 +3389,11 @@ static void restore_planes_and_stream_state(
 	for (i = 0; i < status->plane_count; i++) {
 		dc_plane_copy_config(status->plane_states[i], &scratch->plane_states[i]);
 	}
+
+	// refcount is persistent
+	struct kref temp_refcount = stream->refcount;
 	*stream = scratch->stream_state;
+	stream->refcount = temp_refcount;
 }
 
 /**
-- 
2.43.0

