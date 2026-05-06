Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29E9CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7517310ECD3;
	Wed,  6 May 2026 07:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXgBPbet";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0D910ECD3
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLuF6SfMRbiy27cU7yXLS9H9YAjMfTcflmAZ82GO8OGIJ0uO0sB/hjqvOBp+wzFCAWDFfzr/AWS8lRypEKdfcTn9Eptum2W96TJJNzDOx4WdcV7tmiiG154768i9IDtJbyZJsyGXTOZjwX5DT/lLnZPSx2op00iQxQj8je2mhzNLA4TUSyCmj8dP+5B4KeDctv/w/BTHo1SVEJh+71SJetzWpSWEKngwqfCQZ2Zjm2gizNAQm3VnZHT5bsU0m8nvoApJL9ijnQXFs5Mz3hjb9cIzgA+iQqkWZYWNZqNzrqi4AH0LdfpXlhIbZ8TQvguT7k7Rg/fpYTkEaQLrHFAHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IC2rYEPxg3Z3I8SZpKwy5hLrAvn+8N9cybY8kDME8w=;
 b=ILgYdo+nytDUSF8e6nanHVwhKwKZWKv4hx4OWXOiyYCBGyUKBD3Ya5cIx4b+vDyTff/QIj0v73tCOoqT9fnQHZm6eLsfxF5IoK9APqkcVMIBKApldb0764YtdLCzrx5z4ZdjlQDTNzI9MlzSGlYUbfRfNBgH0C0h0hVlfYbFK+hfldyv1Ih5VghD+ZVCcHrqOUL0eahFdcOTwuDM55Hrxn/srcd9Qgmv+ESy2tzXFr/IbY6lnYkCjiCQ+HvU9Wgj9NFwlnU7v/nHUAHV5S5to9yhO76Rb/FwAv5QgtWsZJl9Xg+m6iR40B/GOSodOUCvMEq7TYrY9BlkxEjGclJU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IC2rYEPxg3Z3I8SZpKwy5hLrAvn+8N9cybY8kDME8w=;
 b=eXgBPbet6eVXGEm1M6MuxgeK91Us2XER5xIR9FDaSIJ28zeMWh1bNH+Jod0ENZfeBqPVKy6RuqfhTHoj0eL7qt5j8paCVAI+gq/MjjmVf64881FUOWfAoFY9ONQ01F8cyfCFYkMGn5+/ckcUzLB9kve4vbtO8Xpg1B1X5IhsRVM=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:03:29 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::47) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:03:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:25 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:03:11 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 03/20] drm/amd/display: Fix CRC open failure during active
 rendering
Date: Wed, 6 May 2026 12:31:01 +0800
Message-ID: <20260506043342.2164710-4-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 33742870-0816-461b-3cb4-08deab3d9322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DueIR+x5THqAH2rwYX0GWBnjEUxOIjIvk83LFe1/uS55phry/+ANgdB5l467Z9QfX/gY5CQBXWEURI7OwH1X7gJ4nAjgR4qkt2EVqjrSCGNVkFSy7iSqap22MdL3c9v4Y57YijdMpLl2eH3rc7HsqXPI2XXQfWmYfCeiUbgNhoAnO4tXnjDFDCKc8gcnu5c8vQdQIZ8CvnMyer7cn95l/LjDQV8ek7BjmGbip0aST7dEW35GGm7U6QzKSKZ1r/VBy2j9cowedNYwrTxniaGDO937UsTt2vPb4F6mtXEiJCEcN6Ga1Gh+JyeVYe+A6EY4bzDkjQl+Pt6gsaW/hohf+/ygoYWovVJck1h7fPLjgvbVZtj7pZ9Tii1IKvtiaBOb3ZM1p2Lvx5Xtv8cpjS3c0Ycf3sG71UJnEE0gwFjrqyajLLYrHD/qFXl2gnS4yjinuCnP5euJn/ineyrzvOPCKAg7CeEtAviXAAkNGbm6gaRPEBAK5iduMADm3kIcJeMr6RZM2XvGudWkx3h4lm0HmkQ+IwXY1uMxjXZ9QdJHUnGNhnT70emVkeBcLnxsZlmx7sLbTUPxjMpq35wqFMV5wIiFgIoeuImQhKdOMR+TwmAqmu5hVfuaGR/rbf6Wzo9mukfJaOUayMCLWekPnmsK5oxWE1JlvD6gkmTStMKXwDhb8MpOUNkGgQKgi7oWAxKCs7sDhHmDiud/gmG8R4ZXqh1QvHxfXqCHgVcGLXyJuvc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vn7qq7RA9UKaZsOIcJLX4+iPJ14TsexDvTWU0DAJtqow5yxTLmgwicnVJyISB5auOdHTfO4yTZ8IWvjqn5WWkQjY9R01e2BpoF/1MkMoyu6BByfvefo02XIsnew7j0LxS/55gdimeHxf6QG3MUhcX5VXYkrSsWY1UtdIqiXVDomwEqUDX0phB1EDt+BbIYGlNJvwjofbXyAJnQFOE0U0Ah8UQ1c/DlzDFZFrF9rIdYPwrS+xzLGQEIUUJ1dLG1JUYJ1mw8WBgGJ3bTAEBREU0D56jBZXZzjVI1pkd0MolcQBbEd5GsNpovg4vMLrPfAnSI3oUxwpgLmM6Qu7/UPThqc36qiKL+ttR5BQnfflc+G65akNQ7G+oqRsw+gD4hrinwbGlVIc9L2qV6i5hiotRR9McrYNhNxU9hXLELDWl2jInqD/MHMvPq5Z9AAY/ppI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:28.2410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33742870-0816-461b-3cb4-08deab3d9322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Opening the CRC data file during active rendering can fail with -EINVAL.
The wait for commit->hw_done returns remaining jiffies on success, but
the CRC path was treating that as an error.

[How]
Handle wait_for_completion_interruptible_timeout() correctly:
positive return as success, 0 as timeout, and negative as error.

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 2663593aa35c..e9834d7b6534 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -613,8 +613,13 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		 */
 		ret = wait_for_completion_interruptible_timeout(
 			&commit->hw_done, 10 * HZ);
-		if (ret)
+		if (ret < 0)
+			goto cleanup;
+
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
 			goto cleanup;
+		}
 	}
 
 	enable = amdgpu_dm_is_valid_crc_source(source);
-- 
2.43.0

