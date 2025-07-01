Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA16FC83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 20:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE2310E135;
	Tue,  1 Jul 2025 20:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P7JLOQYE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B356C10E60B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 20:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCzRWtMQt8dM6admPo/jZeldwQsxKazPWzq1BjGtPc471XzZR3Yjt8i9o5UG2hb+/Pp/9lLgHlZuMDBmxOmHv6T5K3G0hVKMOPtTU3LBeqmcMEhZGsEnyC72+HKcoNsoQvHYdoaNMWRZDzu/sKUcNuNwCXTo0N5rpUkAGN5bvUFGf2hC/UcFL5heFeFKcm4GiyHNsZzfw0FcJ+rR7S9Ti+F6fkukmlOJUXq1Hm6kDPthLoRHAJtA0jPBh8t7LV00teUkf2NKHlm6vWq8nmycI8AQhtRDOcF9th3ZRS57z7MJ2dv6R03VLZ+7YeYVST6hmR1qu/+o7aPxcOTKv22v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG8vN0Ty09ibHBBSG1gbMlS/FSAuEV8AnT76gz35wzw=;
 b=uOKmmFUo63b5XmNXZX31ad5ualkbt8HupWmaI5DEQAYrI4zzj4slVHHjUmUBKUT8CqBXWVDlAftaDPnEH6UxG4x3O6piDFxVRQkaRzsmEZq7Ro4Nw71c9QiazYTYRHaUxsRIR35YjJQCo4PQEmTUECS5NSP7Pb3E94d6tUYZa2pMoM+dOs17CgxCPNdYQ7J767YCbMoC6eVtQSzTH8A0hnkOGXemvJd1EbciHIIT+MBHJi+/YN31fDjiYDqDgWmp6668s3FNSdKK0dUtYRUy+Ye3iu5R5Og3qrIc7QFn7DAp5xu3AGS6nFrF297xsV3XhhsT746hnORpbTy4JuEIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG8vN0Ty09ibHBBSG1gbMlS/FSAuEV8AnT76gz35wzw=;
 b=P7JLOQYEobffHvFhZY0QMm9sPRY2i+S9lqU/O+xX8kwu93NlRGUHC0nvnHPjGez7zbnrRC6xDiGqRwgG9jZR8XxkyneCGHIU7EDBufKnlXvJb6jbmSNTyRbx8njfo21uTESIgsr4J+Hfq9V2a5diCRVEt5OjnWwpm2b5E8H9ITE=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 20:14:53 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::ee) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Tue,
 1 Jul 2025 20:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 20:14:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 15:14:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Disable common modes for LVDS
Date: Tue, 1 Jul 2025 16:14:37 -0400
Message-ID: <20250701201438.424760-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8125dc-0435-4209-8647-08ddb8dbefd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k7KMit2Z/4mhH+KeCqHVyjoReg2+D/qrIHr9Scn3ALcmpvqtpJkTuX7mRQNY?=
 =?us-ascii?Q?9iRUuHMINn548X/2wzvrk4HScKSX76rApLNFkAZVa+FS2ctfcY+TdwwWvOQ7?=
 =?us-ascii?Q?6DgzP2+dj9NVfLvmOBd4K6y5O1GXOMX71dConGAn5Ic4ByknrbBQMB+KT0PP?=
 =?us-ascii?Q?YxLtR446J4jSlR9SDhOrCbG257ONpLPpksHKPxkjvwL+rltJftFCMQSgp7zE?=
 =?us-ascii?Q?TPkRxaHRJaUdI2SD4QEmvvJIFMekB+pfoDkYNqRGsZcgj3DyK+X27X2haM0l?=
 =?us-ascii?Q?og/2jitto0/1gfA7QY+0E/KF0eHmjAvDThO9Z8fDnQ8OWrcFOj1Lm4tHZAyU?=
 =?us-ascii?Q?5nmNYhITdezzh8s4bhY6Nll0x8O3jDJ70dSEpTKOg6krTH42CT0nIlGD6JT7?=
 =?us-ascii?Q?ADMGtd9DJxJvteTeQZZXMV7gOZUIJOP6OC3T0+mVkXhiSHxCINTLsogH6+Xu?=
 =?us-ascii?Q?UtJlNFCZbTajZsRr7PdcMW9xeYeqykXz7D6FhWb4/DGyl4dHF2OlnLIS6PaA?=
 =?us-ascii?Q?tN2YMt85ZXEr0fzSUA5k3AuqrgwUeB2XybQm/dCHXXKXM8eGTGgBCN/OSADp?=
 =?us-ascii?Q?zxMT0kzCvlGWsiUxOwmzQrkMaSuEXbKnwJxwqYgxruipfj97b845a6Fephrx?=
 =?us-ascii?Q?zs/wRcUsFyEbOODhopKEYCFgAyzvxsbUF551GFI2kDi5NqumFPVzrVWyOPc+?=
 =?us-ascii?Q?rRv2xwYwaYJoRNsTgvOeH8NJGaB/wsOe2uCwysCpPNXKl+HkdT9ZttRYkNIF?=
 =?us-ascii?Q?CVxK72gblbkUURAsdlB5hKIfCH/dfdiG400cASh3ZvciVa+HtrSakCeg3MPp?=
 =?us-ascii?Q?02yoeUyfrVjlU1ao4ipCFSuXLWi+9JjVEEPlrDN9ZidnIMPWVe4MLAo/KohS?=
 =?us-ascii?Q?MDOkx+7eb5zZyTUgiQvUJfGGEprx2xDAUJUrg/IT1jIhq3eRnXAjr2l9tPN7?=
 =?us-ascii?Q?3FY8m9HmUHikig5oaQIZvfq6AwjY3J5vDkF2BNi4oogmvzb+xco5r40JhaUD?=
 =?us-ascii?Q?cVW7MOSf3KYW2RdgA3k2VZizsLEa1Bw5u86pggrqDiLBt0NVPmXSxYc+ANdp?=
 =?us-ascii?Q?QtCb8/hWNm5pUGIedm40kvungM63P+UiZoRt/TuaiomuJQWvnoB2H7WZZv49?=
 =?us-ascii?Q?f5bt34I1vAFOElZDRvdQTsMLl3aezv4xzmBSnAZO5PcVR4ZFznQezqwO8oLn?=
 =?us-ascii?Q?GihkGzlCNfWR16UY0KHSQV9J7eSDJwKB6gLqV8F8V/zbC1OD8as1bL2UKGaF?=
 =?us-ascii?Q?GMf6npZpvVFgVbVpEcIpglNmWBFOBwjlXOH4MdRZhpqls1EA+2RymQ31wDJ+?=
 =?us-ascii?Q?Bg0IqX81tQrMqHiWCbfO1DcGQWvnoxbDMMwjVLGTMRxZDjpI3jH1hOvXD/Uj?=
 =?us-ascii?Q?3RvJvAoV+RlqHRRKw45PJWTvegyL59ANSmKo4wy2RKEYx9uM4Q5h0KpAQYYs?=
 =?us-ascii?Q?QlPdBjJMR94U1qiSyK3GFNhTQAl1+YzoWcGubXUhlhG5JQ6sBSWk6vGcE1cT?=
 =?us-ascii?Q?E+q9IegJ0Sqd/cPPrbQ+F8L+qFzHaIH2RD9q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:14:51.5975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8125dc-0435-4209-8647-08ddb8dbefd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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

[Why]
Common modes are added to LVDS for compatibility in clone mode, but
not all panels support them.  Non-native modes were disabled in the past
but this caused problems because compositors didn't use scaling for non
native modes. Now non-native modes on LVDS will enable the scaler by
default.

[How]
Check the connector type.  If the connector is LVDS avoid adding common
modes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3dd4f9e9931d2..7a4fca9a61bbe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8374,7 +8374,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
-		if (encoder && connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+		if (encoder && (connector->connector_type != DRM_MODE_CONNECTOR_eDP) &&
+		    (connector->connector_type != DRM_MODE_CONNECTOR_LVDS))
 			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, drm_edid);
 	}
-- 
2.50.0

