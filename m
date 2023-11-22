Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1119FC61DA7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA1210E6A1;
	Wed, 22 Nov 2023 22:24:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D146310E31B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBdPzcDBMLzQouE4zJOmh5Kne2iJ73Sn/D/qURO8Fr9a/YLXS7GkSsMhjLvInDshGHq3NIevLpKzyLPnnYeOPC7zu7JpUEIAwE8hzaDJauG60P6kC6lnLwTaBxH0iBWnHup89NPM6raa6FzpEnTZaQOvmdU/IHnGCUJUvOt2WPY7PAPAn7RvvgYQnYr8yeZd6SIAjpSGnsRhSNqOiyOSIBxmgllRjoli358+GSVW82Q+0L31c2wHr8YLaPpiRDrofLfXIqIMePxTsldFLp6PlnXZFXDNXzO+uow+zhZwwsWejfH98oFFz2dHnUKzCWVlyceKrtAwZcUT5UYbNufGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ9HqPTpmL9eDNDiNzlwcny6Qnfua7LMrx9KBxExGNU=;
 b=Ab+Lk4WJqnqdCIaD/gBm5Hm62mMoRYr1KzSCsFK3jweB3rIfFiV3EGTs7X9ERgnDmtNWScWedvGzp5n2UhqPqKrPOgQlD+kB81pl/jqYD82xafsB88jCc8N1555Ikn0FkePdZvm/WpLEBKiNuxdRFtRHb/37clp9wPOCYsup+vud0LH578fCcpK9EwxMvdR4qmAbvcbXXN+ZvSpeSisHekfbZC90+6XcA06bhZKIz/9wNPB69WSorr9rq0rq8UAleCvMpm7V4nXDpio8RW35wVljekdzxBYVMBf6Wk0ZfJeLasoZamoSuGR5hBsabo8VrYB954KgAGdkV0Vn2AVS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ9HqPTpmL9eDNDiNzlwcny6Qnfua7LMrx9KBxExGNU=;
 b=5XIrxl8TDY8evisHKurX1wXIqS8jTmkcwv7bHt6XU9pIuKRTfpTz4vJUv8BKfWUF5iJHTP8ZLOQuuTvrsIy7QhmVF9pBOaM6aNad8Vwv3tJ5roA6dxqgEorntYRhigjmka0TWruFFo7bzgk1vj/3ctPjbWRwVXSKVwO3ysiEYec=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:24:27 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::95) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 22:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 22:24:26 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 16:24:25 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix ABM disablement
Date: Wed, 22 Nov 2023 17:24:09 -0500
Message-ID: <20231122222409.53901-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c56fc77-a108-48f7-d9ff-08dbeba9c9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xK2luIJ3frYJkm92AduuLFj3Vq56fyiZEW0PioZB8/sg4saeMCkSKLpkIPGcOVj7Yw+KmJF2NYeM1XaZIhb7frI18WqtVuHEokdKRN8VFUDucGVg1din5grsMhv5bBj34YymxogHe0g/FosVJqIQoWn3gV002PPa1n1oic0CRhaU/KPuoeJxSnJfbc2/QJDLB0FSutWtsJh2XUKJI7FFS3hIOMBa5T5TrEkttApJvrbFmJz0XHqPPMFkko71N3pP8LzhIrPLWQNmZ8YoNWMmvZKLliAhVzWT2ECXRDL/9neWs6iHWdxtWl7b+a6lN1hJFcYVHX5pv5IuNT64+0IVmislByGjyru/3SKO3XF05jqwOi6DQ7QezIM9RNO0acyYZffxozauDxABFXKPSwuWSjrrERjieE0CzFpjTir9cfCy3knbZJZPG98j+PpPnDl0PCdZMgehglXB0tPchrQS8NWcaG7k0nw9bvEqXvW63f9zPITEt4YcphW/MYWYyHMdhnpGlak1pKytOPLkW8puVDEQB5JWeZR69xgn96EFOuFMqVa9yjU926ASlDeOvuSDlQpkhq4/FWXFny/6CeyNTsc+AlBVDX6Hdiiieud3TN5fjY1xriG14MRB8fmzbQ3qKGXgRDE9eahI/n1FxFl29CTNfhjLgY+7yWVkcPBFvEPEys3SNaUaNv8v3/e2ost6JqBR5WbywQ2kMMCMIkMpkkazpNpinmVMvOXG+9VecVA0ZT/Mk+/2ILma4H2Rj9kfi/1o6JdLE1IjtGcZgTlF98TNPvGaLSV5xWhzRsvpU4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(44832011)(41300700001)(40480700001)(86362001)(6666004)(40460700003)(2906002)(5660300002)(356005)(81166007)(36756003)(316002)(6916009)(54906003)(4326008)(70206006)(70586007)(8936002)(8676002)(83380400001)(478600001)(2616005)(16526019)(26005)(1076003)(82740400003)(336012)(426003)(47076005)(36860700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:24:26.9069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c56fc77-a108-48f7-d9ff-08dbeba9c9bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On recent versions of DMUB firmware, if we want to completely disable
ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM
level to DMUB. Otherwise, LCD eDP displays are unable to reach their
maximum brightness levels. So, to fix this whenever the user requests an
ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,
to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE
to 0 when a user tries to read the requested ABM level.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d9496db0ecb..8cb92d941cd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6230,7 +6230,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 		dm_new_state->underscan_enable = val;
 		ret = 0;
 	} else if (property == adev->mode_info.abm_level_property) {
-		dm_new_state->abm_level = val;
+		dm_new_state->abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
 		ret = 0;
 	}
 
@@ -6275,7 +6275,8 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 		*val = dm_state->underscan_enable;
 		ret = 0;
 	} else if (property == adev->mode_info.abm_level_property) {
-		*val = dm_state->abm_level;
+		*val = (dm_state->abm_level != ABM_LEVEL_IMMEDIATE_DISABLE) ?
+			dm_state->abm_level : 0;
 		ret = 0;
 	}
 
@@ -6348,7 +6349,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 		state->pbn = 0;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
-			state->abm_level = amdgpu_dm_abm_level;
+			state->abm_level = amdgpu_dm_abm_level ?:
+				ABM_LEVEL_IMMEDIATE_DISABLE;
 
 		__drm_atomic_helper_connector_reset(connector, &state->base);
 	}
-- 
2.42.1

