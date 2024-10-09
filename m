Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DAECEE345
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E9C10E7DC;
	Wed,  9 Oct 2024 19:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g2MqCkVv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3C110E7D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trKX8PyFAfGhAOjoWYGqFxqFPCktOPSUgVx2xImOSPmR8y5xO2khvLihOKyc5ZEz10gDeIPxxBCZ3xhoEPLCMyJixCAio98rObolFm61gdVhrc3ENDSLzOOjK2CzbRWPGco/qoLZjhLufUti+AU0wuV9bYPHzZ9vH+B4MnnsCMSYjHTTJIxe3HyHPP1zTdFYRCPy47nms/5FXDsFLkQnQSZp4aQHcLnKf4QcoALCvuJL3CimT3papTYwxiWlQ/zY2v9EqMx5Hu0k70vQ63tScxwNmVjloTi9YmQBxmCfHBD3KYlv6dr6M7ZsV1izk7O6MhXyPB/51369oF/XBYVD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjI3X1vZZItQxE0vYPGd9f5rtapUmur4d9l5lbrWyfs=;
 b=N3lvv+z87nFjX5aLx9xNneXbBZyjq6Xc76e/G9AhRKU/EtbZ/NSqi39n2JhcUxslaipMWG/XjPJ08kq9oQIYoiAJ6rTQjj34T6zQ9gwRU3jL9uKLH7eKd3a3bCihnBpSIf/UqVhrdG46ZQCSenFsoumt8JMfHy1ghJDQokfhYB+pcCphBGywcyW+D/kKkXJkhI1ZLIc2ySUFiaNl/vHflXAv17m5KaooQbBc3UBv3KzVOm5LG0/hcHEj//ohw1AYUWj7BgMyy1WjSEmC9JrbUgh66dfGv9NAOSusE9UDzFLOjn5rGLifxWyDdvMQjFbHJb6Im3H7Ctm1OKAtjX88dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjI3X1vZZItQxE0vYPGd9f5rtapUmur4d9l5lbrWyfs=;
 b=g2MqCkVvDwilUEBomOUhwddNiQQwIjS98FGWQsICgScWGfY/PXGgZqhWGwHUWG/qRao0jfvJuQCxXPBL3oYB1J2av703DJxOaCq8OH205Uj+48v1Ef1+EE8TjS6H1kkDxGGBqjo5jH18RN/U4cdyALLG3OpQM65qfQE4LZz5Vmg=
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:25:48 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::42) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:25:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:47 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:47 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Check returns from drm_dp_dpcd_write
Date: Wed, 9 Oct 2024 15:23:29 -0400
Message-ID: <20241009192344.650118-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f635c85-8058-4ef0-3c5e-08dce8982e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ATuV5unPCHJCEmEjkVOlwkr6xniDmzj5usFwI+iPbCF8zU00+KWQJxU5YJze?=
 =?us-ascii?Q?qnfwoOMuw9IWwla+9AS+0XBnvBwyJ8CeQPDis5n5NWr6u3MNXE7Ic90CsrXK?=
 =?us-ascii?Q?kvbqCAAhJ6Uerp+HV5m2RMgXLgjPMXuKS78YBH5syDRLvqxn7D08mNqVjHVv?=
 =?us-ascii?Q?ffPukeoU8kmhUteSKUF3J63KPSCGBoF1tpIw2jRagEsBPOLLRzUK0nYpFBd3?=
 =?us-ascii?Q?h5gjOW0EiZ+AoCBRDfA4RXY5e5b8623wHijm+0tvuTH/Asmu2+UkuSlyz+tA?=
 =?us-ascii?Q?Ju+FdPETTItLfJHfbcUTP+lCzO4jwWLzjj7e+QQeBybFWCDULwPKOkqMjQ/I?=
 =?us-ascii?Q?4Ns4bxgUKBDTWo5vxcYzFsQmORo7AANRdbGzpNsjXXhUHcaDdpz92rjIm8Ao?=
 =?us-ascii?Q?afLCDbV4Lc4bwsRH4SLnAzuPSasyHdeN/3IeZXQBWiP1xgJ6sLJywyCwA1iw?=
 =?us-ascii?Q?UomBm64YqFLouqaLYexY7bnbCYW+T5CQfXCxmV4aTPQfrdvF+dEyXsGsL1oh?=
 =?us-ascii?Q?d8w9+ckQaHRPEUmAIx7l3uEhCT1Bs0z7+d/sGV0//8HSbiV2gi10qO/w2766?=
 =?us-ascii?Q?hcHCcTYoAdR7Vo4ZImtO9mf0a8BcxAc1FHPjuDvXUO6ghHGmtVx/2+SH2Xxv?=
 =?us-ascii?Q?o0kelpmMZlEvbWhn6wxzaFcQbUxbh02TCdpVcsLauhzVptRY/eOS7jpbCcqL?=
 =?us-ascii?Q?OvJXJ7ZK5ukmcNx8ns17bL5nc7TgLwKGPGa3G0/Hn4SPKo7K8BRrUJv6yF4W?=
 =?us-ascii?Q?Y05OErBuMJ2NkKSiAp+ZcJP+ISgbdt9sy6rC9j4E71D8qFk5Z4W3TNxLVfPa?=
 =?us-ascii?Q?807mP7TWR2s3E/9Rq20hXtA/Ri1RjFedZ/2XkbdoZ1JCsMjj+OwdOM8wRT6Q?=
 =?us-ascii?Q?AA/ih7xHE5dO/Ev/Tzz7pyc53H8GLmdzb5d5iUfd9OlsS6E+E1TQtyfNgsnO?=
 =?us-ascii?Q?kazkEjCOGZCzenJTEBXENSWztlcUwdVX2SR9zt5gtDMVrNKOxBaX/34LXf+c?=
 =?us-ascii?Q?hH8KtONn482jFM8xSB4HT3LumN0pX41w5bNlY+PCPca9UqFWuZagCdPCa49c?=
 =?us-ascii?Q?mazj8DAAV4uTkEEz8/jTN256L7WoqaHFvcdaNlN0wNFUl+djxVM9hqfRPZ2+?=
 =?us-ascii?Q?T53sO7cbtXx74Tbg1KGkbFldwXSrN581rh9YU3DI6bZHLu8jyxpZxjcO61Un?=
 =?us-ascii?Q?S4DaQ79YJXNpy1Xpybj6cCcy0fXV4phqnGa6sIpD44CTQWCnSwfAS2mhJV1+?=
 =?us-ascii?Q?m91klSHf6IyXK6JOWpN7bdMNe2KgdH4zrBMMT1Af3WOAJ9GnWvtCh3xb3ijI?=
 =?us-ascii?Q?fTyRfcQqZDujox+mUkLeBkGzoYGwAOJwZJRp/nh74ERp4o3R+oaYflaK3jCI?=
 =?us-ascii?Q?RxSAmJlny3iQUbQ8xZFq5ZUAQtcq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:25:48.4893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f635c85-8058-4ef0-3c5e-08dce8982e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
drm_dp_dpcd_write() returns negative error on failure and thus returned
values need to be checked.

This fixes 3 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6923184a6536..8eaf292bc4eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -643,6 +643,8 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		// write rc data
 		memmove(rc_data, data, length);
 		ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_DATA, rc_data, sizeof(rc_data));
+		if (ret < 0)
+			goto err;
 	}
 
 	// write rc offset
@@ -651,20 +653,21 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	rc_offset[2] = (unsigned char) (offset >> 16) & 0xFF;
 	rc_offset[3] = (unsigned char) (offset >> 24) & 0xFF;
 	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_OFFSET, rc_offset, sizeof(rc_offset));
+	if (ret < 0)
+		goto err;
 
 	// write rc length
 	rc_length[0] = (unsigned char) length & 0xFF;
 	rc_length[1] = (unsigned char) (length >> 8) & 0xFF;
 	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_LENGTH, rc_length, sizeof(rc_length));
+	if (ret < 0)
+		goto err;
 
 	// write rc cmd
 	rc_cmd = cmd | 0x80;
 	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
-
-	if (ret < 0) {
-		DRM_ERROR("%s: write cmd ..., err = %d\n",  __func__, ret);
-		return false;
-	}
+	if (ret < 0)
+		goto err;
 
 	// poll until active is 0
 	for (i = 0; i < 10; i++) {
@@ -687,6 +690,10 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	drm_dbg_dp(aux->drm_dev, "success = %d\n", success);
 
 	return success;
+
+err:
+	DRM_ERROR("%s: write cmd ..., err = %d\n",  __func__, ret);
+	return false;
 }
 
 static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
-- 
2.34.1

