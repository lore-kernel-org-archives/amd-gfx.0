Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E491C44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB34510F71A;
	Thu,  9 Jul 2026 21:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xP3P2FfZ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657A510F70E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWBV1VINcwc0XUJUPDdGn6FY2X64erWDSANU3hR5afNhjaRxa1ZW11hCCDfLzNV+r/xuT8Lkzq02NwJBHBW/vpu2kOf4tDTLhprfwXa+lNJJapq6qvORnXK/5tobPv63UUoA93XL4y0GC3eJ8tesEPW0pyBOwwlkLGwQ2nI+X4bghP1vh4XkASh/nTpLeBd2iv1Bw7z/4Vz+/Iap3t9lxf0rljSNtXhYQbAy8sKYlCw04OWdX5GatoEsxlaGyhDJ0u9lVOVZ8UHpBlTRpZ3l0ltCBUs8gOaqrOFvxGHSpokqWdJB/cr4c/WW1uqTRSQHf69UA46YaAUraEBB5ADXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43t3PI+Qxny2wNroMUOT+lh7SQ8HOIuIg9CfO9KtC+Q=;
 b=mXP7uDtD5aajCLAeI+DfLlCA+GvCQVMAJxyrjclNIwWG9dPBOI1n1BqXEosrqRs3mmN59Bf19E3/cbiA6S4INMD1JdIcdfHcWCWE4jSjRufl7KEBVu9fDkVIrBmTTf0u3sDZ440gRvseZvkapAJ9yJKrerAbcq6Tk7Ah5E4dksg4pntYlaLnB9liv4v9sCXPwqL6iTPh+mSYiHiBn81E+fBjcf+Sx+e9kfc6FNxSId5FLcKoiyBuNRWwE7din4DVpNT1qho4OOkJGhtv061cooXE1ZGkfL+I+BTDn3c4dqSKvXjUMW9o6Xg3c21YBFsHRf8HkLpeyfRff3N7b5zkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43t3PI+Qxny2wNroMUOT+lh7SQ8HOIuIg9CfO9KtC+Q=;
 b=xP3P2FfZF/tZNzVovfIRRwGs7KBGcvMVNsTxJweZL6Z9+S+yBZ9CkbXbXLwNNyvMCaVVDG1ycLPEfCo+ito7PGXDOwGnUmHJlItUtBSY5MiotMSGONLqLPwNDk4qmEoxu1UoMwIhEMJygzxeIrp87w303/R1JoLEHAEVyMM7wIQ=
Received: from MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) by
 MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:41 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::7) by MN2PR01CA0041.outlook.office365.com
 (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:40 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:37 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 80/80] drm/amd/display: Promote DC to 3.2.389
Date: Thu, 9 Jul 2026 16:48:48 -0400
Message-ID: <20260709205936.5719-81-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: ddea971c-4381-4182-7d58-08deddfd6a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yvU/Ts5w7mk820U+QIi2QO5rilCTcZYDfnDPoWaDU4VuYgdCMqVIvoQ3TaFYNQbDy02FWmjANd5KrFEqU3ZeZwua0ytXg0QaGLmbkaUjqnWZyD6yO4Aht5wflnza8HrzzX9mHsHZWrDi/SjOmrODJnuHrubuh6iXlyUhOCTTcsT39tbu2mO0A10gTNmTR4XhiMdD6UMBR1jdu9PHSzkBnlHyHVIYeitCx43ZW+fxnRMQewmDnvZWKy9feMxnUJPsuOoQ5c9xd2sDVH4PfjfKA03TYB6Kprw7HvKZLrzq5yDi7CltQlfL/xSWAAIggM8JQhIkWmUayfP0NXUCppt1rfvsR+LyBOZipr0HQ9v7sjQ8hYyoBZAZ/rBqvJ9EGT9uHV2MKfMbg5jtP4wRkAonnTbtAqI2FWQ01umks6DSG9jQXND3rNxRFEyH3JYtaLC+W6V2XcZVkZ/p6pWh+FNmChkf50i11uFDlQxikzUmH791oRW7ayHf6OBk2fiEd5HRqENsWbZeX5ilF4WQZq70JjvZaiOtswx9qvK+MchxEqCOxE4rIcgkrhzllIJr7G8Dg1VOO4ll1GldrZHOgpwnUkUuHTvf160e1dUzA53gU6UPzQ57mJWPE7Gym4Jjt7/vOZcinYruXJMdgvk2wbcvF4TYk+GtPo1TRliIgoDbgAttJEFDYYlsDv/yLFIThJTXc4jbUnqJXHaAKwnGbhkRSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tb6BMrr+lYlL6V3wCRVBL39FewktCCJlLut9pl6H/FskwuC62LpAkp98Ft7TzSExkeDDWfHzrOFvFujnauC6PZPnAvFTgbGoA8431h3l+8UhKYR+CLOzNPRJYWS1MhUyONgi/3YGDhjnr6mb2HcPL6bAqEThZWUHWEA32YdYbVI/JEDDJyNIOz2uoe3TysMsjkpJAEh9zkVSerInd6OzN6iwlg7vKniEZFSddYxgYs0uRBWRfxmPo5KQF62cPbubFZuhVRM07zo5TYAN3aO7un5MESOGQgor0hM4UUebAPjwwZDzG2cJ5eTRl/Yt9kvPNT4i1/+h4RTk/vZOhVhUhSha1ERWwjf2MuujKKX51X9JJpH/WtbZrSial8BBNmkTXK/8bTX5bW6ME/Z4D9u88TweXzNgz6g63ksoAcfn70HrveZCqCWf6s2nWot0VGDh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:40.9076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea971c-4381-4182-7d58-08deddfd6a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fixes on EDID 8K parsing, cursor mode, backlight, OLED/VABC, and HDR to SDR
* Improvements on DCN42 clocking, det allocation, and power gating
* Greatly enhanced KUnit coverage across amdgpu_dm
* Code cleanup

Acked-by: George Zhang <george.zhang@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 572559d403ba..09b1b8db8d2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -65,7 +65,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.388"
+#define DC_VER "3.2.389"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.55.0

