Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B725CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C98110ECE3;
	Wed,  6 May 2026 07:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UfSHMxzj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AED10ECE3
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkZk79+iXCpmTBNi445BNFIhs7gwZ2Lt0AGw+teCm93lMRFIiZzs++imNII4DMnEg4Rs4n8+KsKF12KNFOxrcBo1crV8Hhd5NnwnRY5M7KLD0TKt5nK0k1smbh6vdEIh4MzMyfQODZTq0fpA7Tep/NJi86Y4Galj0474dctqDXP1CVLXvz6ZiJLA/H4erm7JkzUxjsoizrg9Ut3WEUN399bXsK0DUN2mrRTX9vVNqzDj58yVwmsY6DbQCCGrPeJWW9KA/0AyG4Sdoi+8IWP+3GgCcHYutNb72/++YZN/mIaMeerJZsqfIqAHvMhL3OkNotx9S+Xm85OjyeNO4/z4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN/WpWSjD5n43Gsnv+YcrOJAGdJ+bEQUZAcylyVEJkM=;
 b=Cj+fXu6KhpgTQTqoNuiSWCrbNmqRYjwspVOKbgmffhgcUty9w9gR0cKc+SjTNbBLe/AqKvFB6+VBZoXOK2cKdjR/7cUAe2tAwvinQmGmdz9CzzBSkJWbwg6wY5uAdsc0WkY7UA/camVKA6lgoQBqYXFI60SvTRxMYNbl1zMN6nV2TPlngE7b2qn19rrun3S++h8yP0UMhLLADI2kSOmAh3EYu6LrGM0YZCsQY+Ne7DVlgucbih8t5rITzMTC3kZzHISBOquJv2dhfBsqYnSdJLr1x5ZpBrAvD7y6aalbfxO1Z6DuhBawVug6yt2+z+1lynSNVk4aVE4POGnbJjQBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN/WpWSjD5n43Gsnv+YcrOJAGdJ+bEQUZAcylyVEJkM=;
 b=UfSHMxzjg+bJ6W+t69HaUQGTB+XO+MWrslQk9TYLj2HtVurJQzReJObAElBbx3eUFjCCfp1/g+u7ASGqnOQNngVlJPkuQtrEzY++dLLRObXun4hS+3mSVmXQ3D+g4sqcdtLnbGXZv1uKgflVd8kEJDgZ7SQl5Iu5TUNq2kFzFG4=
Received: from MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::8)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:05:18 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::ef) by MN0P223CA0017.outlook.office365.com
 (2603:10b6:208:52b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:05:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:05:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:05:12 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:04 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 13/20] drm/amd/display: Enable IPS on DCN42
Date: Wed, 6 May 2026 12:31:11 +0800
Message-ID: <20260506043342.2164710-14-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: f66daaf7-3f6e-4981-c2b4-08deab3dd4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Tudu1ZHyv1NtzRGdS/Q7IRSA+QsmD9yCOGOCRVy+qxVbf83oSr4wZL4E3SQc7iL9bnxIktq3hBfY2qIdvaN3Zr/tT5ekesERQFdLdydnhF/MGrgLJcwC6IDAGjjJwfBfw1gszoUndG0XF1Dgg4mbW/frmgRUCWoXnTlHkgQlgooRiSeYRcsnffuvAnGLx7fl6CB3mOfrYCpH9zuiOoxOJCQKrQXRk642RSlzrArZHy24/qWoiNpT7zGgfZ9MXyPANDKZUEEF5+fp3cnraWRojwI5JH4w5xVwApLYnMbdurMH45ySYkaZTyWWnNiexdyQdiXNmpwbJdRn5Mu7b2lWhyDgDcW5fKBprdSS3bNnlhFN/GtQG+VMRFUpFHyG0qnjAYfj/1e1wt/w3Suydti/xhQgH/rMkWnDkOvbelyMPNQOnWJNf9g2Bt6UGvxyrvYYytUKIyP/XNSFff1wTL/syqcuSGMNtpPFrIwWpITQphp9dkkbj+F01dKb1tRaO4kMjuNM/IdyKefYlGL/fIkDRoFbSKTPEc0HY6YCySWLH7T2fRYpRPSXvUlKh6jk7PhkvLF8aK0hKSSIX/89C8UuDFN0mDiQE1uBTL+bxQdKwt1ZikSOj8HtY6KbPHEiH7/A2KssPX0pcGmGRfMcERFxQc6ooipqUmj8Nkqba89jQQZO3CneD0L4bJWn8fVd0aCMuF5EzaKTjKwt3Skpcm5zSIQyKpqcKdE5skS8bn0NGcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VEf8AL2+NX7bKvhLiue2WaX+9MbhybuqF9pKWJwyA2GLndQBkqmCISuCBIoGx+flTlQqLbc8Ahf6/iBxuvyIQFzls9nM90f8RyUsv3vLG34fz+rJfNvW3+KbjoTHmrmxeHalluC1Xs7t2GsxZIItmj1ywo2Tf1fTK+8ozyZZxBcx09kjrnLh0xeiS4oUTImtSTRj2/SDnM0IimtCl4HtyZhr3bM5QgNiK9ejRbFsDbEs6iq5XjTDzIBPCNP4BGpa0YevCB6DknuynRsQtEZvDwrDpsgsAYYIUZcqfZnnjCu15EHgEkTUtEFNm4oPAGyhtI4CehjJqPkD+IvD0ex7GL4nmpupKN7jt5kEBwR7pLzrxGVzZ15gIu5UtDzay7Y0+9jvQpE16sw9HdDQ9/VS7RWVk/4Ey52cK//3xoPpPlLqtJKRUbXabmbaIAti1Owx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:05:18.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66daaf7-3f6e-4981-c2b4-08deab3dd4ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why & How]
Fully enable IPS to achieve higher power savings.

Reviewed-by: Sunpeng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4e9b4fd505c2..c41f017fe8f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1867,7 +1867,7 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
 	case IP_VERSION(4, 2, 0):
-		ret =  DMUB_IPS_DISABLE_ALL;
+		ret =  DMUB_IPS_ENABLE;
 		break;
 	default:
 		/* ASICs older than DCN35 do not have IPSs */
-- 
2.43.0

