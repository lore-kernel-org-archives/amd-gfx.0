Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3616010ED674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 13:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9BB10E1ED;
	Fri, 27 Mar 2026 12:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QL7xqex";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759E210E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 12:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXzkxRj3vfMKjRY8BH+9QnCIeH7nL06X9hF7V8Oq5SicEd1DkhZoR8fPGQ4DOvZm5ts1mYBnvsjNI9117JYZlTv5EIQaL/eYJqZxaccR961VDcte0T0wYFnKIPp+mAzT4o5kGdFJ8o+3oMxXEbNV1fG4iSzPm6gtXmsTj66moYDTEdPkW3bDlsVbbHYfR+ECfPXeo1KBgkE5l9rQ/xgKsH70ggAsVJnxz7WB0KQIHt08VjN8oFsO0iP3oUus4Uuz0XwIGZY/AeQpzRDoUZgpvWdNro41giWTnkiWPdk6ojgZtIM6x4nHJSnZsy3lPR1K1ODx7zK5ZUS0bKEp9LoKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TgUio9bzML+wTDKmazA8bbH+LPs/ibX1uETWHXI1Sg=;
 b=G70RbzNOTCNK/4eihzV6YgUnnQ+G+RuCkmEKNU3P7lE+gmv1aKncXziHr7pDnIM1lNIqbqlT9TOGxVQ7HuIfmP8qXNhqoqvnvZ7O4RlerhihqfqSZYlIANHtHKS0GtpZ3AL5Zc0orABpdGg8opB7InWz5EE30nV7BCxQxSsI6DoNPKG3ANBQPenIH/ul06j89Drlnwdo2T36iaFpRgbxlky/Ar7Q0NKLx90T3aQHjGPrq7dG4gEcqoudO2l/u7vdFebSlMtU1AnbmQNp1xIdENs+y0RdH8Sf6pRPlr950Cu3wu6FCP+6zDubEs2szhUXQ8YnAw0blXq7lxGVjDGlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TgUio9bzML+wTDKmazA8bbH+LPs/ibX1uETWHXI1Sg=;
 b=5QL7xqexyuHbTtYs/qT8ngiFwdZ008bIhzlM30SZ6amjajJ3BNsnC7psVDJs7P2RWlLQ55w/zKOKNfRb1nulwfjMNLe0XoDvJDSij4fcftK2JA3dbsLgiUZpuEUCPsZSfGEPp53nDSSSi5eV5A+zNFc3Oo7yuhE9LKnOfFwsnNg=
Received: from BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 12:59:54 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::4d) by BYAPR01CA0041.outlook.office365.com
 (2603:10b6:a03:94::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 12:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:59:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 27 Mar 2026 07:59:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Muhammad Adam <muhammad.adam@amd.com>, "Mario
 Sopena-Novales" <mario.novales@amd.com>, Tom Wu <Tom.Wu@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.5.4
Date: Fri, 27 Mar 2026 18:29:42 +0530
Message-ID: <20260327125942.2114350-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: b712abfc-d691-4105-a900-08de8c00bd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: groTVs7xP6BosIrtp4Q/U1nJjj/i1vP01dGrUe/+PgmMt07BP2l+tCrsI8Lsr0TasuUYPmudCIn6a+scCbYoDyHgAjoZFN9sj/ENNQGk2TcYYqagfBIWTnYo/Zn1O972tJI8FVZQtMPyH3finhvtj/nicrl83JjKkXGhJQYUePytorunScBEeRzZfVJ2G0tbxNiib9L9LHfTw2s6eSnVe7dp/XGLGUkOO3pKxZIJvIbAH+DNcYiV6C5cGiucW0ZRz7e0AFrAhctRH4uXEXjwqpaEi92HZvLZwNuoNAUZcAkPHnNKiflCN8Kabei0604ZeDtFr0jF/3aGH6XbNe773+w8PLj2KynttFfS8KN+5YAeRH9Xdk9siFRwWHuXAhrYu2DIC9845NdgpmGqBxUhjYCHxppyMgSBniEjdPJgOnXxaCkpomf7GDj29gS4/GYA6iOt86ZvbN/LO0aoqmB2k9JL0YTh4DHBuwYIxfziUTBz3Sk3Hm0Q4Vu3LpwccXr1oVkCttHAWmW8EYRuZfHYgbgmSstD1yZxGt2qkTwvYkXmAHXMF/TfGaZcUUACYmqgFLtyhj+dqkkZk26MxOmllD3JrwT1XkSgMrNquZUU+WmSdYgMe6ua6nALPYUNKYwoPQRS9eoYXs54x+jxNcsmkZMbTkq4ItfFEBZTaRR1ePCvlbusBCrfc+u6/ZzvcM7N8q0FnEttOduKjui5Bk8Src2rHlUzGLqE7aMF76AN5uz+lXvvoxJ2Cyf3Cyv3L2Bu3IINlVeMDTA7Lj511bVKkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B6QMjDehOETcqGxOUc+Ctf5yD5tIEaPw2US0JALTFiGZZcKjphEF/wqqwiUQedYnfAp8s1o9Bu8lpeNRBB+SLlQBoSXGoLsDiAB6vls+7gakikcHWcfQrNRj4Jf+yN5yr2K7CrOynSdyYhhNwYZKv6JD9YWeW0m2qdGeosUQBQpSjdWKLrwm2IvaA5bifan6B/kSay/0RcYdlgBmyQZVEXehhCKs2mywIVu2GsFecfx9OlPVPTKVadyZAcWYZrhwX+9yJe3g/uVZvuL/Cu/zOXBybSoUV97Qw1DkWdzBtzPuAp5FYKPPYClZfW86gl+tpKPFNP0tW96jm5YTae+ErOae/wYHtmQib07nkfeDiipWu5rvGc+wgW4Xg79LTaTj+L5YugRQhWieA0ErGsjm22037DrqLyX5eVLatL9ohSNEZ77K7ONF5v3+HJm3eOtz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:59:53.3418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b712abfc-d691-4105-a900-08de8c00bd2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

The Cleaner Shader is responsible for clearing LDS, VGPRs and SGPRs
between GPU workloads to enforce process isolation and avoid data
leakage.

The cleaner shader clears per-wave GPU state (LDS, VGPRs and SGPRs)
between workloads, improving process isolation and preventing stale data
from being observed by subsequent tasks.

This reuses the existing cleaner shader used on GFX11.0.3 and enables it
for GFX11.5.4 GPUs when firmware requirements are met.

Cc: Muhammad Adam <muhammad.adam@amd.com>
Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Tom Wu <Tom.Wu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78d1f3eb522e..ae39b9e1f7d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1722,6 +1722,20 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(11, 5, 4):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version  >= 4 &&
+		    adev->gfx.pfp_fw_version >= 7 &&
+		    adev->gfx.mec_fw_version >= 5) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1

