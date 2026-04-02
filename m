Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDF9D6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1738F10F01C;
	Thu,  2 Apr 2026 18:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nuxyr4hh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695E710F01C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSZHgajv5N6a+Rk6TgpwaJuU3xz5soKiMq2W6ujXhjpD4GIdCLkGBKRB8YudLm68fOwlkd/mgUJFrJmLYsaTrJ3WAHN0hvpf1ji5pW7gJdb38sUtkQEosXgEWRXGFbf0cs/FSGJa2w0AKYTsW+RSB+0CtZGDzbtPsktYHV60ibrDGiLb5YNn7lf46gaVgOQyvvFu2D+dkj+LW5h3tEvxFFP2k5o6F0AoWM1yqhjv5z/xAiV+kTp8OqSv9Xhd5jJziQiueqCmP/fkZN0XSQHkQBMphijj3mgaEegdRT/zNDl6AzIztJsz53DqICN+zPCkOjLXTsF/HGz690JJtu31CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDZOTIYFWIL7MOcICdqcX827g9J83riB+o03XnpAlN8=;
 b=qA01y9AUkkhVRB5zsS/Skxo2Joa1i2EdtzunvQBk7tq7mXGchUfFdfmjloIRMEOhav9Q11sdy+wDOfUEFbtcecDGrNEDxF56sVRCFVBeXqAoUz1aaefuUBecCyK8ExR/X0tvgs17yQFiDiKFBn9yYLfUr7EtOMbufplt3MZLuwR+vNQiKWQLeEKy6FKU6JUBMxozC4x2s8DVFCqGP0vx1AO0xMHv0QXppTZ1lvimHOykA3okqiO1SiMACX864JILN4lV2NdldHiXA92lQ8YH9aCZCHY5z09cvluY15v8t//0vcwVoLOSOjNELYN1/5ajmtFPKaKlCB8aweRyJ1hVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDZOTIYFWIL7MOcICdqcX827g9J83riB+o03XnpAlN8=;
 b=nuxyr4hhsuQpErvMf6gO2+6GkZgnMok+A7u0eQObMh+o1kiwIDBX+8XLuyegElc072louNTeePgTphiNcdSNdhSXWEEA7cbUP3G7AwPsdh5ipCuFORpJEiFUUSico6HbFb2saWQGZbkuebIlB1qHnsvFBiwFFGTbhNIPMWM8n1s=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 18:33:44 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::cd) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 11:33:42 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:36 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 06/22] drm/amd/display: Adjust freesync pcon whitelist
Date: Thu, 2 Apr 2026 14:32:58 -0400
Message-ID: <20260402183314.1388755-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2fdc4a-743c-438a-134f-08de90e65e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: osYRJ6p4DLTN1WC2Ilm0emqTHBP0YR0hBnpcqpQc5ZTHu9gtVqKIK1RkYEEtoGz08Y7RYi9ZC794J84Cl9twRJuaLChX0mjHrPYZLAB1yaQqvrVXnju+yYnKg13m8ury2xRs8HghAyX4t0LbPz0VXkWQimQd2FuvMSQMgYMBzokU5RoZwg9DGYGCXHJl34v2G10yscvfeKwytzOpnQKTAnFfKob3omuKRPBI7msmhTK4bGPMSeN3Xs49nFWIVYXjIMmQ3erkdMt5ygoSLLmUSk0BuV6kwrcOrVXQkGJG2kjCcd0MNTzSixZ0W/i4OT+qFMVLtNJ4h0vk4hE5+lF462F4vh2lxV1ZXOEmE614zOVRAziGuXyvIRs+dpAY/VIP8j6xm50bHccyM/2nGaU1rXJ/3kF2PBRn+kOQZE3UFCyRZ5EqUhNMnBQaDkOOPhBJxxq0To5BwUzKGxOLy+ItFLF2dyB/ZYKrOJf+LZDDHqtTiihBKohtsjC6l5aiFC7PPTbFgRZXKRvne12iusdHemtdgcNMK66fpEzFsNjhyjPq9xngLHtfdr/OE5cl/h4TTQOqyruTzXefSalP+/C6A9nNxZDkFJxkFyJOj106/IDrg/2EFW21pGWp22wKDTmLCPZaeTIuFyuFXWlO63PMxBM3ZAZeKT1IvY+q6h3BjOcLfslvTKXjKe8n9NRz83Pp2X2tuW2JftRm2AZR4cYLi7ESv/9+SjQOENblUnHMOIrBjRZyK1wrs49UpjjAlmWFr1mGVO0KdYHtKJC6RCjrUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E9rJHjC1kjHtHb069TmmrT8gN5uGe2XPN+twVELKHujVoWSQNKGwmzgcp217ltGp3yTFSN9nwKyRMbDdazKqt3wxgkr7/k4141Vj3cfmlvH3sL1Ki8+4Hcr2vKnCIZZ5bRPAM1gv4lz4yNVJaEKaXcEngc0I0V++/htCU+2K0C86qcAztfzNV8we8a+v89yIiEjbppjvAzzXDBcRrUqGIrhTjfN8zmai00r5wcV1rd4FY0JSDIDukM1zP8LyAsC72+dV7WdXA+1R1tlzL1wNw5Fb9SnowblwC2huEhfTr+uWLBMtGJOFX2tLWG6GtFgJFLSZgr1Rxo5byeqNRntActmZo4ygind60NiCQFMwWyhRmDvgzcgSfVs/YNGjlMHJJ5Nqb33fUE/U5RYHISz4k22eIX8RfiDuO7TN9tbEuHmiLZOrZEPzHy4eVDZj+d5C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:42.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2fdc4a-743c-438a-134f-08de90e65e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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

From: Wayne Lin <Wayne.Lin@amd.com>

Add more freesync supported pcon ID into the whitelist.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 ++
 drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d7b0b84b3865..6de2eb34f862 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1400,6 +1400,8 @@ static bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
 	case DP_BRANCH_DEVICE_ID_0060AD:
 	case DP_BRANCH_DEVICE_ID_00E04C:
 	case DP_BRANCH_DEVICE_ID_90CC24:
+	case DP_BRANCH_DEVICE_ID_001CF8:
+	case DP_BRANCH_DEVICE_ID_001FF2:
 		ret_val = true;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 1c603b12957f..53210e3aa0e0 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -36,6 +36,7 @@
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
 #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
+#define DP_BRANCH_DEVICE_ID_001FF2 0x001FF2
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 
-- 
2.34.1

