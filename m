Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86674CDD1CD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4FF10ED00;
	Fri, 27 Sep 2024 17:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPKTIsYF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032BC10ECFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI/JnsbEmPg9113cGrH2uacikfZ3vzO4eueDmk2Mc87RjaYmXhTgfur2xuXDha/s0617gqfbjuvYQCuB66XXzPSUKsRFZcnatp22y51DWB9sMR2ebv7bvYm04/p9uuxmVCkJ/tcEKHQXenGhgHDK2ZI4o1cH3RQcOW5VY72Ak4CKuQuwrtk17Vd4LWXigXz94mEb4CypB+g8w7x5bOUVZfElKa3emQSFdVPJqyRRIQxNXveEDUiKNdWer7AMUkrPOyTtsrIPZjW8Twek4ASZHKBZ5hbckVG+bJEi9LODwwKfPzxZeoPp2E1i+BA5BqDh3RgDYptxC2+skm1XPjmdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOyDqr7WD+4quwlK/JZdG8L5RSsua8f5Ajm++gFX1XQ=;
 b=iZUAwKmS72rzBMNKP+7nU3k7xzpV3N7SdGsspGpqxyDJIr/InsEmxhycwbHzIpK+WK8v2jNxxEH/qfCkWs4FTzpQWHLes4v8M72RL7Xleqyw647PAFqjev1HCU9fLJ3wQeoAZFwfYer0jAOhstnS6/KMYgNm5ssvnycZYioeRbNLEXtz+gAk9ZlU4jHFxzk2ck8Uh+vtgYZrqrhcPFJwoccw9+tcWrG8FIbGvAshzo6l6w35VoDGzstNDUiBTZTlAU8oiELjGqUPsRK3m+3+cXBlDpZ3BTfZKRH93BVEPYoc7zA0mluhEjsIB+ttmw7sqPytvcU9dVojRoR7UgxX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOyDqr7WD+4quwlK/JZdG8L5RSsua8f5Ajm++gFX1XQ=;
 b=VPKTIsYFbb3RtN+LmMxS8RZg95IiWwKTEq31VL8ObfRrOdPGSMhPp0nvBoGMfaKXp6z5AvW7gsq7lBTU3JTwV25T/kH9hrBo7wFalZpS28lDK0C05nNXhy7OAOAnvgFiovikboWhi5DCu1e5v7q1Ik97zffPlA/hkSntHwzMILk=
Received: from PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::25)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 27 Sep
 2024 17:02:00 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::32) by PH0P220CA0005.outlook.office365.com
 (2603:10b6:510:d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:51 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:50 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 13/13] drm/amd/display: 3.2.303
Date: Fri, 27 Sep 2024 13:01:03 -0400
Message-ID: <20240927170103.102180-14-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a6a745-1ed9-45c4-e54c-08dcdf1619f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2XbPr+yQPppFOvzCzM9iBhJPulwkQprITmHAGlceNtJkbTkKGyYejGuMwew0?=
 =?us-ascii?Q?gNMDPzrWWjjR1EDxbyIrKz+FlLTGoMO5bWHfSYUKiifT3KKk2P3vr3+WuhBg?=
 =?us-ascii?Q?FwOfu/rTcXftT/65eiKyyXvf0bbFohtaon0ZiQXGOzF/vQcIiU+Tzbi3+pzy?=
 =?us-ascii?Q?rDW6sFRs3xZeZ3LGZ+CEWbO9VpbTYpdGcwQVH37D3pPdqpZDjImQf/cwapUc?=
 =?us-ascii?Q?lzp9qOUqtyVW01d+mZV/ATob740MVo5FWrXgXERyDWKQxgyto6WnitolYjuu?=
 =?us-ascii?Q?bJc+QRZyH7ZwPCZ8QJLZntO+1xLC2FjR8AAfCG0ZN/Ty6xNvhOFkcRe8aPbl?=
 =?us-ascii?Q?Pv6o2PyAqiISU8vNl5HD18jcVeWrD4s3rBsr/FL/+kcogz2Gty5reDoRtFQY?=
 =?us-ascii?Q?WtaIBsGmD4rpg+vpXKF+DzW32RAuLfPxKaVUeTbovFNMyDruMxicPRUbQ764?=
 =?us-ascii?Q?ENKHp2DPvgRwSpwFwKdACf66EzkfP+QRaQfP724xSRvGIyWsZnUZyeJ5r/Dt?=
 =?us-ascii?Q?Aq21a5IH+Ko/qxh8vTJCUz9Kc/sHOSgsffqk50VNUsYXsbEwcliegzu0ODzv?=
 =?us-ascii?Q?Dq2cKYIVHROQ8BiNeprMV/UddvZ8XBR8oKwtXu0v9ITAN+CzPZHcz7H2g2gN?=
 =?us-ascii?Q?2auJZIWp/lY9lCN8hZwKe/W1K5YaI3V5kN7ol2zURL65Kpw8f8Qta6Q/XTu+?=
 =?us-ascii?Q?RVaZQtMxetkzrhfdx7aC1wWUGlZKtbKqzX+gIztWQZlopxjIIXaqf7SjgF2m?=
 =?us-ascii?Q?b68pPRKmOOb1hvqNkE5CRzb6gyYg9MNUEzvD+Xr0wQ/biW9a9Vt526kf9PVy?=
 =?us-ascii?Q?VKsQhfJyHfOIbfccojRODugn6lun+xZnSPG4i6PVgSJtQIFxZaPPfuWSyd6P?=
 =?us-ascii?Q?QDZUgYulDSA57FaIrpAP04jnc7btLJWTSz/4Fe1GHx+5eMH4XZNznskV+MLw?=
 =?us-ascii?Q?9/OYcl/KasY7VE6wrZJg+UM/MZVazS/Bu3AEsk89RHoqdlHigtcDFBdvhCVH?=
 =?us-ascii?Q?bZXBhD7FbCqWNqPMmOsPlev/ixO9CxiwCH1XkFtiPUyXGHQ5XY96oQ8TuQWi?=
 =?us-ascii?Q?p1Dhi9HW9VVuWWytBRBONqXJHHa+dYgfsFZEfK22jxcbdb+jtF5FKeb+Y8l+?=
 =?us-ascii?Q?DWCa4TOK+AA+Wqkh3e/hzzvhy5z0HITRS2EyZHWve4S/kK11Nzgr4Inh5VDe?=
 =?us-ascii?Q?5dLIrB+t8HDgAVr7oQS5btKcep1GOgPTolIdY392fkNjH/ZOGNzCQoTOlp5x?=
 =?us-ascii?Q?+AFLoI4IgDiCrEgJ+HUzpBR4J5RJ3INLUo/a0uEKeVNXDet7gBOKrG838gaN?=
 =?us-ascii?Q?3hPemenXaYg32zcQYVhcpyhAi4NKZT8tw36jf8o3okTgT+/2VnJt6BS2sxnr?=
 =?us-ascii?Q?07dzfWY1t94aeXW5rtvOC6CtVSpFAc9F77dvSMij4ddAOpBnpIY8VO8yFW0L?=
 =?us-ascii?Q?ifHCH02Qyr6jz0XUMNfaSdbGmSwjMAV/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:59.5712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a6a745-1ed9-45c4-e54c-08dcdf1619f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

From: Aric Cyr <aric.cyr@amd.com>

DC 3.2.303 contains some improvements as summarized below:
* Improve brightness control
* Add support for UHBR10 eDP
* OPTC required only for DTBCLK_P for dcn401
* Fix TBT monitor resume issue
* Code cleanup

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 059e5f4ede49..d80c91eddc75 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.302"
+#define DC_VER "3.2.303"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

