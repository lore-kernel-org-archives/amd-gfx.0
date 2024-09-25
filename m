Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D868CF9C71
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 03:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C4B10E772;
	Wed, 25 Sep 2024 03:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKjGYTCG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A2410E772
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 03:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gunBhPHjNYJRnl3YU263DswA27IVYm0N4vKjvKW8MiwdJaEkT8BTlpAFQrFSX2edB4jtuwrQMUzDrLFebrvl73V921ILzbhUBk0Cj7SlA4ZVLuwhAS2wZjWrtjR2aOsW4+Adml7RwQschR7c4/M8D9QxmnltGy2faNzJXQ9Rp65z4HiCwiYtDyK63wN683wIJF8r++VuGlnSRVJFdrSismFJDzXTuwxZMhAZCeL8/nx2C7wh4te9LOHvJT8gbpInidBuQBK57Ziv7m85IYhKBxXXlKZEorT/j4xOrGGYnTxpveTtdAvfYluXGBAiqBPZbgCS4EoAENX/AFI08HDNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NVY/qmymfrWNIWnhj0DuICbCk38IDHmkrdBJgxC0RY=;
 b=V19Ts6uKFzVKbWa38Cg5RodQ+MeozL/onbt7S+1GnSUC9hluM3W+P6dzP8LvkSvPGN8RZjUo8nTav3dPbNGhJYaLUqa8q9sTC3aRGOtJGeUndhIaov5u8nJu7S3GyE+abkbUlmdA1eSsvkgD2QpWs+BudjZauPzN/FmA5fgIycQYrvph8jN5xmtzcDuFBRS1Z8C8vOzEHLruVapw/e9v1W1fUfns1EPCEEl8By5e0BKlr+NXGgzGEfSHfF6qChe7ljLEIbK3Zq0YuiiN6K2nyZXGG1SgVCLuYDZrJowyMvQaq7QvnxNw9kI3gHVjuGXsIPymLijBDYRVtd/22JWTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NVY/qmymfrWNIWnhj0DuICbCk38IDHmkrdBJgxC0RY=;
 b=tKjGYTCGfXHG78UvZznoLUpIAzTAlMjp125Hs7lHsbVuaWYI3DTPR++ZycHj9FEAeyZ3QGA1Dea0vmZBpIwCs9e9KK9A0T0wOGsqti2vb6BGmYrYasnnkoqKM7JgUQfQizHHdLAmLNKCMO93cmJ+A4IwB6fSVZp3YnaoXqxXCBM=
Received: from DM6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:5:bc::48) by
 CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Wed, 25 Sep 2024 03:11:58 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::b0) by DM6PR13CA0035.outlook.office365.com
 (2603:10b6:5:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 03:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 03:11:57 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 22:10:35 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/discovery: add ISP discovery entries for old
 APUs
Date: Wed, 25 Sep 2024 11:09:50 +0800
Message-ID: <20240925030951.603486-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240925030951.603486-1-lingshan.zhu@amd.com>
References: <20240925030951.603486-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 687ccca9-27bb-4504-bd92-08dcdd0fd102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EEpS0tXbh2tA4FeHcMk/XcoQYYl1O+0SBkFQ7q/7P0pnTur4FBLoAd86roqd?=
 =?us-ascii?Q?AtWBrjKVQ9dHQf/jkHx9O2VvwssiLmzOq6eJPzy/5u/Tu7ycVSrlRKFiVpoD?=
 =?us-ascii?Q?kzzYai1pf28AHRXAtRoP73FNeSM7f4eLC+kT0fm2szlPTCgnNwSsIP6Jikni?=
 =?us-ascii?Q?V/fyfGVCp8alYX1iBY0eGGOi5dVIfShAvea8BT7lTf5P65vX7yPXdTOFhDRP?=
 =?us-ascii?Q?zuYXLpoL0CuzAxfzRAPgsDAPycouTWmTiS4Yydzud/nM9KLSpUh5QgN40cvW?=
 =?us-ascii?Q?YFPYnSVoGiaDq0GFhZvsUHi08Mv+ZnoW3c/K7UK3Qfxb9WeoTafWsbomTygn?=
 =?us-ascii?Q?jtZ6Ao9htu2WHSK8zFsdIwdwl/JNmqmMly6fOMoKjmeNYhW8TqNEoXyKHXqn?=
 =?us-ascii?Q?0I5W4jDjZEdF5WVg0SFNi095iHwiVorc3jMs3qEChGPs3ONEx7a0bJCbsEdv?=
 =?us-ascii?Q?LttWUxn2L5RGVhfR8hm1cYJ/YkI6TG8iI0m5TR7/4VT0W8YKDpGfG5jHYNc/?=
 =?us-ascii?Q?fmNfGQ7FDnu0hPzYZjUBDeY+uocwImBYfG/5P3chOW71Leej7Kps8bPbwJzM?=
 =?us-ascii?Q?6+zVAj5ldVZcpBGlGz89wXGwzZsYqRrOT/87AzKYPMx/tJNjsTFOvTfHD+Rr?=
 =?us-ascii?Q?84y/rgjpuv0OKzNBoAYhWLtpgYDmG3/yDh+QPF5ddFQAJWyEBg5cJPZEWz7M?=
 =?us-ascii?Q?/4semrsRoqZxZ83NkGmAr/2e59tAtfj5p9WfTlgX/ZdfMmAvWlD/pQPxw8iU?=
 =?us-ascii?Q?WP+f12UQq2aCOoTgmVr21365EuRggd9aw9BrUMMnXRs592zVICwNBppwxpHa?=
 =?us-ascii?Q?3U3rGv5WshappJhmiREFx9REm5chXknfraDGk8EV+L3hBQzlp1dc+tt6qMAP?=
 =?us-ascii?Q?7LhTNl64XIiLGYdrUroPzbXUGz6oXpbk8v2jp4rSpPvpSLDQ0jG+RFphmJZL?=
 =?us-ascii?Q?5d1g7NmmCOQUbYxmgXOm/HmKs6IVSi9WsXN+11tEp4WBopMIIxMb+lWie03K?=
 =?us-ascii?Q?7wXDBj+1YqrYcqMypWXQtPkChMSKbb4gzURz3D0Puow7oh45+YpJUsLAGvkA?=
 =?us-ascii?Q?ClBR4tPpai1+SbZTkWCd5B4/z0m4IFIZYcfCbfRoJoSyBl+BC9XkpiHncgDb?=
 =?us-ascii?Q?eMLsL2u7uGhoYUWR73nmZD6iSU0+jf0srEKy/I8r6ceYhKZXv7TeRbJ4MlGE?=
 =?us-ascii?Q?IfRTFJ4PfTob/yCswyS26uRIoVutXlyqfSLC8kdFYcFlzIYNLI4jgNOd8pjs?=
 =?us-ascii?Q?w3J9EOfHjnCl3QESte5S0+o41lQJi9ty/eonKSCz4UlCVXbIfQbRVz8sOSET?=
 =?us-ascii?Q?uCWORs7I6aWVtULotJDsXvkgbKba0vmgAqxHKT2x72dfaizkjMFdfxvdJHI4?=
 =?us-ascii?Q?oUSKkcA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 03:11:57.8914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687ccca9-27bb-4504-bd92-08dcdd0fd102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
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

From: Alex Deucher <alexander.deucher@amd.com>

Raven1/2 and Picasso have ISP 2.0.0, however their ISP blocks
are not in the IP discovery table yet.

This commit fixes this issue by adding new ISP entries for
Raven and Picasso in the IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4bd61c169ca8..343d390f6293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2492,6 +2492,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 2, 2);
 			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(1, 0, 1);
 			adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 1);
+			adev->ip_versions[ISP_HWIP][0] = IP_VERSION(2, 0, 0);
 		} else {
 			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 1, 0);
 			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 1, 0);
@@ -2508,6 +2509,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 1, 0);
 			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(1, 0, 0);
 			adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
+			adev->ip_versions[ISP_HWIP][0] = IP_VERSION(2, 0, 0);
 		}
 		break;
 	case CHIP_VEGA20:
-- 
2.43.5

