Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4BEC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FB810EE6A;
	Wed, 26 Aug 2026 23:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jzfon9e9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A12D10EE6A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFHWnfuMMpcrrBm9IrUqjzJCybm40MdXeGv85eEfj70LxvzPtoruFTgG/tGmB+RLxZzFn78LWkWCU1VKxs4jSam1f5y+aBenFyKo0xV4LOGxnUlyhjkC55wYlkPdSyZ6mh+AzcyAGHSXtzps7ax3mQ0TD90JnLZVrTMmTNC4qt6DTiw+mPeKSVoMqpBSJdpWOcDh+4TGwR7ftlPNmVDYIH9uuhEMWKT8FGRswbPG/m5xUNGbqFEEZ8GZVjb7DGqqntSAZqKYoSG9tXlRD9yiTzpImjnSaDGdogm6rjfXlhfYVvi3wVX2KKS610Usn69KMx/neRjXhAe800GbsR/WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqoUIOQX1EBdROVla3Bc38GjsTwDAPjXSTvE46f+qfM=;
 b=xXwxS+sxlJRWA/fhPTRm+4KCwYlnNLE/LMuU1Jk3KH5otSPRNlKvUn8nB6oc8O1Ex29cpI2c/CsqLdAIdM2eiJXofEvkC5FyCCVUEoEUcqT6TrNTHN/etXlltj3IrbdVm5BhZUnuacpMnx3JAbAWAnhqj1y7VKMRRoy1wGPERfyPAOr5n+U70CkPYITfmmEbIHas6vV9JkcBm0ECiY6avErtqIj0mm2449Fc+mk48CGMJ0D+U8HbXRsc82/YqEo05Pcn6jYW0WqLj8uNcZLuL9tEDGKsbVsIVwlFrOx1047w+U0g5aPlARIwUsTpOZ+HfaO80eBtkf1H5cIBlEL8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqoUIOQX1EBdROVla3Bc38GjsTwDAPjXSTvE46f+qfM=;
 b=Jzfon9e9HbmWmqe/fY8UjaJhrU2fp4FscGc/w+fCriqMN2yoNAgAeZKIp23ib764Wx6uWp42CQpivj/91kmkDJMayNXexvwIamp+RMbxV5/VhNeENmVSdP7Lj8ml9xOPvqMAwGcxq+j8a5e+TwF0gDbi2AtgQPOG9IY22E5LV6I=
Received: from SA0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:130::16)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:35:02 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::51) by SA0PR13CA0011.outlook.office365.com
 (2603:10b6:806:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:35:01 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:34:56 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>, Hansen Dsouza
 <hansen.dsouza@amd.com>
Subject: [PATCH 57/59] drm/amd/display: Apply debug bit for force p2cpm
Date: Wed, 26 Aug 2026 17:05:28 -0600
Message-ID: <20260826231519.881949-58-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 80774fed-4e92-49c1-b055-08df03caa634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RIdipVj7miCYkdYNFMJCgdvA2esA5L41Ch+pBITLX+/eMIQ+YHIHPPsHI0FC7pGaVsjupVHL9kCy1daiY8Q74i2fuwgHEkjBNzlTrbz+K8JT0hmpg01WrDLzR7aec2ZvU3gcl8fTwnpbytN5kS+zNuivl0Ilyczdv1lMTqKzT1Z8lbG72MpFY4MZVlNEnZtV6keCGin/tKKhh1YXQgNcOx52vabRuf/9G7doiYtxjWEDpl520MFQHd9UIj/zqHcc56ne8CUCYAh0z5P813k75Jw2QiZHXVrX2Y7S8A7DE5WH7zHCXq9OQ7quzVU5hG4TxojUfk3IcqyxL7A+Zolub/P32r/fsQy3OTPVQuwRQTrz9tjvFYdqRlazOoZdePpumYdZWzH78PDWVfU1BpByPBXxBDSdbJAcokbW+ltGfKeHeDSrkQniXkc5VGzOR+1IXeUlF2xwMLQlOQgkbvy9gnelxuWkC2wGHoQ4elER+K/U9ylG9AmTZlqiNjkTNJzsLrwqFXnxPoMz8Ko9pWZMGdHVPQOmKrOX8z0v++IowfxMHu1x2vSFpV7TGiEPhczbnXSkE1M6OUFgu7D67H0Y5mskjrqgH5qttZUF5K1WD3ELNtZ/Yw5QxKlSYZyLEzr5vyXvwYSYq4WHZdzzfdZhgQx9yKzqwDbl04coFnsjfz+2QcTS6KJo+W5fDvUukV9XNqjCkcrbAq9J89U4GJxVZQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Q8+WEoqgT8F0qlfqHoywZk97C/yRiK/Rh5dX0mqHTk+FbDgrNAAaPcXSMxH1Ok5+kP1lYPZxIBn9d6YEuFfRUuHf/mtAGQxve4122QCElXXvAB6KRNFASKeIDMFbDBjRp9gxn8BvtbuSUsPgJVcKacCwZBTGjDbisUwGRo3aQZFfBf8AQ3fTz7Cq80mT1nqej3bbxBk+XWgADAcwDWRIGnNpAQJuOVPoOY5IKNqVy2CRzpVP12HRnc+IGlPO6XL+6OO4CLX6cUeiBMjFgwBTZh+Kjgvcb8TMAzrZT+Eqr1lB7mlY9zQJIM/TbcQDVq6YOksEadTSR3gUfLKzig5UB4duVn+vVqot7hW5Y7n/3Grs16FfDXq6l5fRqrSe3R54LOwl3rEtWZDVmo4KyTL8jPUKfL/DZUB1odXD+Tv20J1FkeFHGV0UWoOWxEPDKpJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:35:01.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80774fed-4e92-49c1-b055-08df03caa634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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
To allow per panel control of PHY settings.

[HOW]
Add the quirk for specific panels.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ab15ceec4daa..93fd5f251a6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -131,6 +131,14 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_colorimetry = true;
 		break;
+	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4203):
+	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4197):
+		if (dc_is_embedded_signal(link->connector_signal)) {
+			drm_dbg_driver(dev, "Force PHY power down/up level 2 on panel id %X\n",
+				       panel_id);
+			link->ctx->dc->debug.psr_phy_force_phy_power_down_up_level_2 = true;
+		}
+		break;
 	/* Workaround for monitors that get corrupted by the PHY SSC reduction */
 	case drm_edid_encode_panel_id('D', 'E', 'L', 0x4147):
 		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
-- 
2.43.0

