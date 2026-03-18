Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F2FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F41410E663;
	Wed, 18 Mar 2026 01:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W6wXEgNa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F6210E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3uz0mdjsZR0kpoDyq4dQc3DwvzfxR7tG9FcW0en+u/r+lHgKNA6kHtBsswEAXgqGyJmYXRG6OVSF7R1BiZ284AViU6DMZC5DIXEqaFp7ezPVQFUjVD/Ks0/CBW+91Trp0+8YgxOtF0lHqK37zzDlLIY8BSjZ0jQfppUYrSx2Lc1RadFm+XAFh6yDwendISgJ26I1QEvdOdbM2ZeCYFcT19ZVLMGcxAVhfozGqppQ1q3gYIBF0Cl0eWyB7F54IQ29A1tYVpr1CHXGuAA2rwP4SL6fYTIt72Nd9LqdMIZomDU5RwrJPJjUbOyopmxR7ddYfoA658Ag8v0r58yWF2eJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Og+LohrKMdS+RpYOO2C6evrXXB+6t8sxBfytTJsrSk=;
 b=MY6qBPtbovLtVCL3NqVGRawJOZEjY0FEcuV3ux851wC9pCUZPXpMUi6zQXwOjozggdwQFAAkx7RobVZIhRAfTpes/hJJDuZl6Ldb0nmqc/C55dbyMB0It9AZf09tbld4ZlYH4ZKilOuAoB/XL6DA4lbu+tW+M9uWEW8/tNEXL1p2RQp6MFo8i57Z9S8PFwSDg8dmH5xrfm2blmIFS1Sult9AOqpwWKAmHXlOq8I93o54/VGUQLFNXWYpEZFXKoteUJzvnmydCZ5ddJhA4VmOOVUSA89RKsayA/g84eTiIZWkqgJfo9/I2vOYFDiBVdvMOAwTGC2IMSIafCnw/TRKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Og+LohrKMdS+RpYOO2C6evrXXB+6t8sxBfytTJsrSk=;
 b=W6wXEgNac4HljuIT3E8YhdGSz9lffDThOjhdobXxkwPQf6Ltb5kHCXQrCnJn8UWaNOEeBcGUckBsQJdglVs1LXbCuISqYH6lZ+FUMgm4VoJBaSdGh8YIKqyxHZcMmolYsP7XNgnYVLXZL8QE2uiH+s4QEdSLeqvYhGFKvsGlSso=
Received: from PH7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:510:339::18)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:58 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::7) by PH7PR03CA0028.outlook.office365.com
 (2603:10b6:510:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:58 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:54 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, ChiaHsuan Chung
 <ChiaHsuan.Chung@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 31/31] drm/amd/display: Promote DC to 3.2.375
Date: Wed, 18 Mar 2026 08:59:40 +0800
Message-ID: <20260318010224.513094-32-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: f02f7d64-b6b9-465b-caed-08de848a184d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5NSJbuedc6uTc/zYN+daTTdFg24zUG7Z5vxV6xwbkYA570d0UPYHJVAqPHPAniZ1Fgu/wmmpcjCf3Wj8F8vDcYSVYl3fqQpPeDxOCQE8KIn16k7xnsfND7GBe1fMDrr1Izzoo3GVWwY/2NHdiwUuWMW21xkX11PsardDoVqbdqSxgGRmH8f5iSnxifKMtIEz96zevAJG2OvLoNhrt8tNa+sqhUleqpz1u7kFNXXTqR7y5kGnRzpbsUkR1VLtUmoWPI5SzDdm1ceHvHwbW6kfrqQnr4QFK5gfXnJ9xawXjyZA44kGQwIakZqYls9FINUkiGcdhx1dupJ8lH88HywgdVQgoXqQWdMWhZlmFg/afsaMLzD+HpfOfqCOasbM8mQEVyUl69dzFWLe/5Dkartcr23FPPQ9a96fdE/AMlTeopA2gcEPhOHSrMEFSOyVz+VSZUa3iGs3zFjMzVeXSq0HWolphShjXp6FeRXUA1huCxWcriQZDDXginePTPFJi0yUE1K9hwqB8Ko6uDhh4fFN54mRoTFua+O9ERcU0kQzaqk9UCZEyWwsiPy7RiEd7CtHitQtE4YVYxcC7o3Jd9VK0iijRIaHy6R+5VdXwzQmIUx93Woyyq4bYRvFa5zNtnruTm6hIBWfvy1slok1WGhifyTY4KsO3k66Ltjtbhu8VBbvxEsodgGb5q3/jJQb+zDVQv9c2E+pmJaD1eFg1E3+s7Jx33WYvTFRGW+FewQc5P8VJtN5faDJHvdstUB3h3V8z7Wjq0dul7dRqZodgB1yJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VSQ8kksJe4FDbZPhpcSTVEMj/l3TQxZwNNDuajmLR/ccWJjSpnj902TuMtd5AojygKQK/hn9oaCfJBQGotYGlQlYhSRwuC+SAQMu+dWTH9YVeunpEqWuIREpbwErHwFy3WEoZEB48bC5XmxJwaAioCLnEiJmyY0SgGWX3Ls7VnlvQHC6ayJk1u7BK0DlVJVsc0NM8gPbzCQBtZU1QVJYxvFYVeDrn9Nb5e7iSDQcmsjQrEIbiwPdB+P4I+AcBiucsbmV0VpDllVyah9yqPRCOHlR+5HknyW9PGRTYuwjoMGuI1dJ/AnHa+YJ/yxIRU/3/tBk3/7wZmaa3w/QdTtWprQQcopDt2qYKZtkkFmqk357lb4UFD3/gBTckV7O3ENDNEAOktWsrYcvaBB3lGLTxC48vzq+CZsf3UVG7ZpXeVr3NnYyOA2TLZX8ZKZu++iJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:58.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02f7d64-b6b9-465b-caed-08de848a184d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

This version brings along following fixes:

- Rework YCbCr422 DSC policy
- Restore full update for tiling change to linear
- add dccg FGCG mask init
- Remove unnecessary completion flag for secure display
- Agument live + capture with CVT case.
- remove dc_clock_limit for apu
- Fix Signed/Unsigned Int Usage Compiler Warning
- Hardcode dtbclk value in bw_params
- Revert inbox0 lock for cursor due to deadlock
- Add 3DLUT DMA broadcast support
- Fix Silence warnings
- export get_power_profile interface for later use
- pg cntl update based on previous asic.
- remove disable_sutter touch pstate debug code
- Refactor DC update checks
- Fix drm_edid leak in amdgpu_dm
- Add Extra SMU Log for dtbclk
- Clamp min DS DCFCLK value to DCN limit
- Update dpia supported configuration
- Multiple DCN42 updates

Acked-by: ChiaHsuan Chung <ChiaHsuan.Chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2bb4c7751c01..80e217c5a23d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.374"
+#define DC_VER "3.2.375"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

