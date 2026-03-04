Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6421EDEC02
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 02:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6750410E92F;
	Wed,  4 Mar 2026 02:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gutA4mg/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89E710E92F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 02:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtnpmZ6XWmPhMe0vgFGFrJ2P9w+KlpcziZdkbvLnz/A+IGodcHFI/ZztjMRuEDtRWuwL6CDtGNtb0whjWHk7b0/xmBmrwvZG7AbTKmppeeFKd3HCDYNp/vt3VPvC7wWmXqj6xOk/iruJ56bDIgz+Q6b7ybS//hJHKKpLtuekkP/jba+i4NAJoXPW68J++MLck4dCyUdk4a/6diG0hxJvz3MJAWTACW9EA3+sLG5H+ujveiM5dC1C5blT4UYD+WH+BhRkx8YxBYKPS0nwIXWCJsrkVbv5M7RXz0CGyh6dYtlxVY9rlWhRqw+K60Bwby9cOWkYGWd90tQN8hNL8DW/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQzSntg9nTbDC/PY8COB7/mD2vpQG4AJ+gZzlnmGXJY=;
 b=FhY09LcjCg6+g52HBxaxmWAYjhic79R6tXvbtt5zAuH4Aoa+OCjtIvKYQpR6t1KVXHxEB7mqWNoyj3KwKXUPOaonlrQ/XPsov4f43oUoy2Vo06sbykdlO4uaZBD7d4qeAnu3GqFRC2ZQ+LpUbytqqWIMDOBycVe5iGkai27CeYQHygSxQbexQaJnT423Qv7dWcm+tIQOcWwUou0L0TAO6sn5lm+pr098Rq5kmu2dZNvFdZWsjYyJL189IRYGXwchaW6l/IXQ4zTwMlcgwPzY/xLLUV/5p2Aw7SGO31UANVB7JnIUAF43Y/U6kImrgejR8hUpvw0sltcXyshSVf7ICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQzSntg9nTbDC/PY8COB7/mD2vpQG4AJ+gZzlnmGXJY=;
 b=gutA4mg/oqzkS1xbJBd/GnDxNuLMnxtLpoF+fO6eBrY6dJWQXqMMQovaniNUP7Amfpo5o+ZioxG5vMa2t017VUdGpsB1lwCS76O+cau1dzDAuZ1nc08lJBM7TeqsvpK13K1IW9Y0QYmxXCjEg+WOvljWcm6mhuSmE/R4hoTc8Pk=
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 02:48:26 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::ba) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 02:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Wed, 4 Mar 2026 02:48:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 20:48:23 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: add missing od setting
 PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
Date: Tue, 3 Mar 2026 21:48:11 -0500
Message-ID: <20260304024811.897237-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304024811.897237-1-kevinyang.wang@amd.com>
References: <20260304024811.897237-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: f12fcb81-0bfa-45e0-d4f7-08de79988290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: tDeeVVjWPKaHkx7h2SwsZV8DctYE0bZRyOk9kjaygNx/sebG123EnJg8Gf0ga3BAy+IJFrVGkvlBA1x6tFZfRFGWAjkAAOS1JIFjLwOZXqtEuc4UIHjompgQKCZyAWmSD+MzTyWlMLyLI6fq67ZwHdbwC9NR166j8D4P9K7l1YtkGnAX7ArYhLpattFozUQTjX+k7dG739zNxvblTFhdPZcd8G45XiX2XDLj13RhYrgJZ0qpyyg+b/4oW/EEE+ORnZZmEPWDVbZ06TPlj1ltzjqJ2z0hJAfdPCzWeeSLo6216jvbH7a/evE5Gh+Y7onwOE/X7zvStjdJCUUqVZGO3SkfRlsmHJKQLDj3N8a3IfUwKlYWmgopFpsx9aad1167wXywiJSo+0xIpHhCBd3DU6/tfRfBOnFIu2bpwtqj7azDpKAI2GzL8MOHUpy60lv4yiyowUmp0l21jDk12jInDiPMnn5Ggi++C7POxjG49fCKFmsmaqy/4PRHtQEWLfNO8ExsQqsMmprIY/SQjHlPfSrEgyGlRc2Y8XRNCLJ0l1y2v8Mk9unFaow18EM2VIYfe6aUa0SqKfaZjFFJbkxvNl8fSIYv9xK/9UgckNbqt1BLS7HcPlfXM/3r0vcsoeoYjwXaGe9V4VmjOo9lMol0n7KeAZMasYKziFANKehrna6Rh9O5/gxtTsZl1IncQF9ueB8wWNV62hBviWrasbF/cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rMWfwFy975kY99m6rIJn7OfSIeCA0t9J0b6Iz3PHh3fcVQXDfTU0ro2P6GikkoMCdlSK/YiyPZkXTWajOLrxsTYfbT8NOZdl+QGU+NxaH4Kc2VnByCVWv3EvoFBzZ2YwHMbILb6n5bjbykNoFhSuHOwWDqKIugT41ji1UibfSu5a7DD52VPGg0lYYhKYYTGwY6reXA/Egk/h0Hb/7mpCSwlvPydsrZLACbS2vEYZ84i/rvY6oqI2yFFQfD6NntdeJeC9aTYiGWEG9mneSDXGHUqBTXXAWlC/0/epHnWAfgyu81S2dq6C0/MnxGqveWg6EBc9j6qSniZAxYhQB30c952njT+R84p462bKTYhfvSI7bZ45ChLk0m11kDUuHMO79NIZ5X9tA2/C4wWRwrEMlVc6Fq5aaBpFE3iK3eXTs39j2fqnUSoxuaBTM6Hq1p2y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 02:48:26.5317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12fcb81-0bfa-45e0-d4f7-08de79988290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
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

add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14.0.2/14.0.3

Fixes: 9710b84e2a6a ("drm/amd/pm: add overdrive support on smu v14.0.2/3")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5018

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index becfd356b4e7..23a143b36fd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2312,7 +2312,8 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
 	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
 							BIT(PP_OD_FEATURE_UCLK_BIT) |
 							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
+							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
-- 
2.47.3

