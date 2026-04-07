Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC32EDB7CF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 08:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6335A10E042;
	Tue,  7 Apr 2026 08:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GM/aGhZX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3A110E042
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 08:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMZTLuicOEOvJbF1rzinWde1H1C80t/KHJchrefEvq2WJVimwMo3bdUHV4AquNmCFm+fxOQcFfYVbZl+jc938gpJWpwJ5VrOZrnHwRGiThcjn2wz/UOyx5xbZ+FLOWgRlLI55vC/2M9HdDdE+QWaL6+eKknYJB1z2XPdzccg69YyjYimFRG4q6KS5EsibDg5VjGH1JWQUjuoirmHL3CHdzMijSkzhGFnBDQujmU7Y7X7kOOG6B2kZt2t4i9TaX2exx84/vg8gdDmYrMOb0xZQ7A7eU0Y8BUlqcKF1nKad4VCoEXgNTaEOYti6leMvW1g4aQIjkmW0wPEh8kXxntTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCdLRPF2TeC/4MofrRp1aSo6i7BTnYTJ27ELNzsLVNM=;
 b=EdrmRbMyUzFBoi8Ek8DCH27+zN1ylzPn3VsSuF/CynrSUdXIlpjPU4Z1LWiueEAMxyM0LPSUhK82yzxu4137SX9qDEyqJNBfxAft3IdTs7Hqcui0XFzvnzPRJClQ57y31tMlFZgrJK+sGsB87ImdTIfhw+DJ0F72IdEUFDAdKQanGONK3hexGUSb78lqZJ2F2oy2P4yfOLat2AP7fxW4oHb0qPjHJ2GlGx4ltcbBrixOtEARHXbWNHV4yZLw8BgLuvopvH3vX9mCsuykao6z+wQ+AryIlJKZPsAJRwZBtaMmGqNy13f69HsD/CPU3ARK5yv/Si8QqF/e27JRJOA+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCdLRPF2TeC/4MofrRp1aSo6i7BTnYTJ27ELNzsLVNM=;
 b=GM/aGhZX8MCkURDDokZbuEULvfS9ex5sAE7etdSfKlcHdiREbFt9x75P6g+wwFtkMYMnf4L63YWYrNhPSf/cHfZpXxu1acSGbm1C6XiOxbuljhd7koeSLDneoeI9lXsC6VilI0pAYt7/qLKQ76Y1FQNYQ97AbEbszUwKR+jGzGs=
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 08:27:30 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::37) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 08:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 08:27:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 03:27:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Add missing do_mccs parameter description
Date: Tue, 7 Apr 2026 13:57:08 +0530
Message-ID: <20260407082708.2265795-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b62a3e7-e2e6-43c2-2487-08de947f827d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: LCAaDs+5yhHIQbyLohc14Nx3K7p9PCSYrFB8NfwYb0nEc+Pju2TQbNvfX4IL9wltSZE94Vy6dd2/bzPcXvDz4pXZN1jBmeJUSzRU2NKSRmJYe1px63LoBFDyz5EpX264aL9jnJFLZT1xkQK+dA/+BcYUstMSJzGgzpecbXit7He5H8RpZOtDC2PH+EgJjXm2jaaCymSK3seLLTWgQZiysH+D7I8qtYA5zGQgJuMf6+EUR3QKT1vJKtOHX7S84lCr/L8xRkGWRPSEtytcr18pDnsLa79b5vmq6bPRm48u1yV4ki4DmIhN+4Yketu4hHt/DaNgDhxPsTgpVQp6HVSXGEGTSyABTs+uaQSQZM2kuM7I18k1QljYFtnDykWH3KGqGglA0fObzfuPE7WizyoEDD0jroedgGBpT3p/4UwhgDGq9TgW/05cTWhu4t2RTRHKVu/W65qga2u+gDcKBUJv/9czolVUkB+sh+Qz7QTxxnZBG145DE7S3iuXmmYPSW3MzOO0wlEfhlsvNIkf/3dCvBYTyKtZpDfCZQx0nOXPobDOxIY27JdNESKEIzCcRDaNzGhu4uZo6ISF4J6NbJA4YR1WxJ04ZKVosmR0GrxzFYZGwisxVXWUXFqJQBIsLBJ/QsRUnmcdKlytyGjZcOd232XZtlYOh4J2/eHKdxKKKNUTrjKFjpu6qxu25puIAv8WQtq4PyyyezoLV5bxiufC36DWKnuMAMoNE0PAPju0ZXrjUp3mfhrku1EWM+NFW6ZrBBn17an2ifLkgkIo8JIAPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Y8qkgyz09Hgy8ia4O7U9wHhWGHuvoOBkgXUG3fHal51xa79gows2ja8xiaE8JeJYdCkZn5ByBWU71GvNXDTN8Tl8NR743J1mno6GdE2CQjy1aDx9tL9CMFikPVWaUGszXBArGB5JIrxt6mQwoGXS84EISPJOqHBEHfoiW2dglGV67kBmjqcdNYsq19bYxOHgqy2PXlBI3nTUiqqwvxx3RNBcY+f5QlJhMXl1WVrFtP0vJpENO1Bq6VbItkVdlwFQGdB3gBbGreP6KqoVXc3bQAZg1pD0+aC1+/AcFaljN7qJJIwAb2RgB4DG7aZ2lz00V+eH6iiiWId4JbMCjCBk4o5bb/vw5ac/l21YAL9I6a/2Bsg5FKJ0b2QOLrSRQe5mTN0CMD9IKGVFXYh9zuuReOKXHirDBpUuRdHbasEnjae8p5ZD2wtgkFrac5+D/m9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:27:30.3746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b62a3e7-e2e6-43c2-2487-08de947f827d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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

Add missing description for do_mccs parameter in
amdgpu_dm_update_freesync_caps.

@do_mccs – This flag controls whether MCCS/DDC transactions are
performed.  When true, the driver queries the monitor using MCCS
(Monitor Control Command Set) over DDC (Display Data Channel) to get or
update additional FreeSync capability information. When false, these
transactions are skipped to avoid unnecessary communication with the
monitor.

Fixes: 980a8981351a ("drm/amd/display: Avoid to do MCCS transaction if unnecessary")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bac02ea15b8a..4b6a1c62bfa8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13259,6 +13259,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
  *
  * @connector: Connector to query.
  * @drm_edid: DRM EDID from monitor
+ * @do_mccs: Whether to query/update MCCS-based FreeSync capability handling.
  *
  * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
  * track of some of the display information in the internal data struct used by
-- 
2.34.1

